import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/domain/logger.dart';
import 'package:cogina_restaurants/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/notification/device_token.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/globals.dart';
import '../../core/utils/toast_states/enums.dart';
import '../../data/model/base/response_model.dart';
import '../../presentation/component/google_map/address_location_model.dart';
import '../usecase/auth/update_fcm_token_usecase.dart';
import '../usecase/local/clear_user_data_usecase.dart';
import '../usecase/local/get_is_login_usecase.dart';
import '../usecase/profile/get_profile_usecase.dart';
import 'local_auth_provider_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  final _tag = 'LocalAuthProvider';
  static LocalAuthCubit get()=>BlocProvider.of(appContext);
  ///Use Cases
   final IsUserLoginUseCase _isUserLoginUseCase;
  final GetProfileUseCase _getProfileUseCase;
  // final DeleteAccountUseCase _deleteAccountUseCase;
   final ClearUserDataUseCase _clearUserDataUseCase;
   final UpdateFCMTokenUseCase _updateFCMTokenUseCase;

  LocalAuthCubit({
     required ClearUserDataUseCase clearUserDataUseCase,
    required IsUserLoginUseCase isUserLoginUseCase,
    required GetProfileUseCase getProfileUseCase,
    // required DeleteAccountUseCase deleteAccountUseCase,
     required UpdateFCMTokenUseCase updateFCMTokenUseCase,
  })  :
         _clearUserDataUseCase = clearUserDataUseCase,
        _isUserLoginUseCase = isUserLoginUseCase,
        // _deleteAccountUseCase = deleteAccountUseCase,
        _updateFCMTokenUseCase = updateFCMTokenUseCase,
        _getProfileUseCase = getProfileUseCase,
        super(LocalAuthState());

  ///call APIs Functions
  Future<bool> isLogin() async {
    ResponseModel responseModel = await _isUserLoginUseCase.call();
    if (responseModel.isSuccess) {
      emit(state.copyWith(isLogin: true));
    }
    return responseModel.isSuccess;
  }
  Future<LatLng> getLocation()async{
    return await Geolocator.getCurrentPosition().then((Position value)async {
      final latLng = await LatLng(value.latitude, value.longitude);
       emit(state.copyWith(latLng: latLng));
      return latLng;
    });
  }
  Future<AddressLocationModel> pickUpAddress(AddressLocationModel addressModel)async{
    emit(state.copyWith(addressLocationModel: addressModel, pickUpState: RequestState.loaded));
    return addressModel;
  }
  Future loadingPickUpAddress()async{
    emit(state.copyWith(pickUpState: RequestState.loading));
  }
  Future<bool> logOut(BuildContext context) async {
    ResponseModel responseModel = await _clearUserDataUseCase.call();
    if (responseModel.isSuccess) {
      kUser = null;
      context.pushNamedAndRemoveUntil(Routes.splashScreen, predicate: (route) => route.isFirst);
      emit(state.copyWith(isLogin: false));
    }
    return responseModel.isSuccess;
   }


  Future<ResponseModel> _getUser() async {
    log(_tag, 'getUser');
    notify(true, null);
    ResponseModel responseModel = await _getProfileUseCase.call();
    if (responseModel.isSuccess) {
      // kUser = responseModel.data;
      notify(false, null);
    } else {
      notify(false, responseModel.message);
    }
    return responseModel;
  }

  // Future<ResponseModel> deleteAccount() async {
  //   log(_tag, 'deleteAccount');
  //   notify(true, null);
  //
  //   ResponseModel responseModel = await _deleteAccountUseCase.call();
  //   if (responseModel.isSuccess) {
  //     if (await logOut()) {
  //       notify(false, null);
  //     } else {
  //       notify(false, tr(LocaleKeys.error));
  //     }
  //   } else {
  //     notify(false, responseModel.message);
  //   }
  //   return responseModel;
  // }

  ///update fcm token
  Future<bool> updateFCMToken() async {
    String? fcmToken = await getDeviceToken();
    if (fcmToken == null) return false;
    ResponseModel responseModel = await _updateFCMTokenUseCase.call(fcmToken: fcmToken);
    return responseModel.isSuccess;
  }

  ///update screens status Function
  void notify(bool loading, String? error) {
    emit(state.copyWith(loading: loading, error: error));
  }

  Future<bool> userLoginSuccessfully() async {
    return true;
  }
}
