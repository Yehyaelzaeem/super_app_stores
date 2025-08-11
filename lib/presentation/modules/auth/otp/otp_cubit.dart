import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/notification/device_token.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/translations/locale_keys.dart';
import '../../../../core/utils/globals.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../data/model/response/profile_model.dart';
import '../../../../data/model/response/user_model.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/provider/local_auth_provider_cubit.dart';
import '../../../../domain/request_body/check_otp_body.dart';
import '../../../../domain/request_body/otp_body.dart';
import '../../../../domain/usecase/auth/check_otp_usecase.dart';
import '../../../../domain/usecase/auth/forget_password_usecase.dart';
import '../../../../domain/usecase/auth/update_fcm_token_usecase.dart';
import '../../../../domain/usecase/local/save_data_usecase.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final SaveUserDataUseCase _saveUserDataUseCase;
  final OTPUseCase _otpUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final UpdateFCMTokenUseCase _updateFCMTokenUseCase ;

  OtpCubit({
    required SaveUserDataUseCase saveUserDataUseCase,
    required OTPUseCase otpUseCase,
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required UpdateFCMTokenUseCase updateFCMTokenUseCase,
  })  : _saveUserDataUseCase = saveUserDataUseCase,
        _otpUseCase = otpUseCase,
        _forgetPasswordUseCase = forgetPasswordUseCase,
        _updateFCMTokenUseCase = updateFCMTokenUseCase, super(OtpState());

  ///variables
  bool _isLoading = false;
  bool _isResendLoading = false;
  bool _isTimerDone = false;
  DateTime _endTime = DateTime.now().add(const Duration(minutes: 1));

  ///getters
  bool get isLoading => _isLoading;
  bool get isResendLoading => _isResendLoading;
  bool get isTimerDone => _isTimerDone;
  DateTime get endTime => _endTime;


  onTimerEnd(){
    _isTimerDone = true;
    emit(OtpState());
  }

  //TODO call API
  //send phone to get code
  Future<ResponseModel> reSendCode({required String phone}) async {
    if(!_isTimerDone)return ResponseModel(false, 'error');
    _isResendLoading = true;
    emit(OtpState());
    ResponseModel responseModel = await _forgetPasswordUseCase.call(phone: phone);
    if (responseModel.isSuccess) {_isTimerDone = false;_endTime =DateTime.now().add(const Duration(minutes: 1));}
    _isResendLoading = false;
    emit(OtpState());
    return responseModel;
  }

  //send phone to get code
  Future<ResponseModel?> otpCode({required String phone,required String otp,required CheckOTPType type}) async {
   try{
     _isLoading = true;
     emit(OtpState());

     ResponseModel responseModel = await _otpUseCase.call(body: OTPBody(phone: phone, code: otp, ));

     if ( responseModel.isSuccess && responseModel.data != null) {
       GetProfileModelData registerModel =responseModel?.data;
       String token = registerModel.token??'';
       if (token.isNotEmpty) {
         await _saveUserDataUseCase.call(token: token);
       }
       await BlocProvider.of<LocalAuthCubit>(NavigationService.navigationKey.currentContext!,listen: false).userLoginSuccessfully();
       await _updateFCMToken();
       }

     _isLoading = false;
     emit(OtpStateLoaded());
     return responseModel;
   }catch(e){
     _isLoading = false;

     emit(OtpStateLoaded());

   }
  }


  Future<void> _updateFCMToken() async {
    String? fcmToken = await getDeviceToken();
    if (fcmToken == null) {return;}
    await _updateFCMTokenUseCase.call(fcmToken: fcmToken);
    emit(OtpState());
  }

}
