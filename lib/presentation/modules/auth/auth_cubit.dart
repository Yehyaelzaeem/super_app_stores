import 'dart:io';

import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/toast_states/enums.dart';
import '../../../data/datasource/remote/exception/error_widget.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/otp_model.dart';
import '../../../data/model/response/register_model.dart';
import '../../../data/model/response/restaurant_types_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../../domain/logger.dart';
import '../../../domain/provider/local_auth_provider_cubit.dart';
import '../../../domain/request_body/complete_profile_body.dart';
import '../../../domain/request_body/login_body.dart';
import '../../../domain/request_body/otp_body.dart';
import '../../../domain/request_body/register_body.dart';
import '../../../domain/usecase/auth/check_otp_usecase.dart';
import '../../../domain/usecase/auth/complete_profile_usecase.dart';
import '../../../domain/usecase/auth/register_usecase.dart';
import '../../../domain/usecase/auth/restaurant_type_usecase.dart';
import '../../../domain/usecase/auth/sign_in_usecase.dart';
import '../../../domain/usecase/local/save_data_usecase.dart';
import '../../component/google_map/address_location_model.dart';
import 'complete_profile/complete_profile_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final RegisterUseCase _registerUseCase;
  final OTPUseCase _otpUseCase;
  final RestaurantTypesUseCase _restaurantTypesUseCase;
  final CompleteProfileUseCase _completeProfileUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  AuthCubit({
    required SignInUseCase signInUseCase,
    required RestaurantTypesUseCase restaurantTypesUseCase,
    required OTPUseCase otpUseCase,
    required CompleteProfileUseCase completeProfileUseCase,
    required RegisterUseCase registerUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
  })  : _signInUseCase = signInUseCase,
        _otpUseCase = otpUseCase,
        _restaurantTypesUseCase = restaurantTypesUseCase,
        _completeProfileUseCase=completeProfileUseCase,
        _saveUserDataUseCase = saveUserDataUseCase,
        _registerUseCase = registerUseCase,
        super(AuthInitial());
//location
  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController regFirstNameController = TextEditingController();
  TextEditingController regLastNameController = TextEditingController();
  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPhoneController = TextEditingController();
  TextEditingController comNameController = TextEditingController();
  TextEditingController comNameArController = TextEditingController();
  TextEditingController comEmailController = TextEditingController();
  TextEditingController comPhoneController = TextEditingController();
  TextEditingController comAddressController = TextEditingController();
  TextEditingController comTypeController = TextEditingController();
  AddressLocationModel? addressModel;
  TextEditingController pickUpController = TextEditingController(text: 'المنطقة/المدينة/البلدة/الشارع');
  File? imageFile;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile =File(image.path);
    }
    emit(PickImageState());
  }
  static AuthCubit get(BuildContext context)=>BlocProvider.of(context);
  String type='auth';
  String authType='register';
  void changeType(String x){
    type =x;
    emit(ChangeTypeState());
  }
  void changeAuthType(String x){
    authType =x;
    emit(ChangeTypeState());
  }

  ///variables
  final LoginBody _body = LoginBody(phone: '', password: '');
  final OTPBody _otpBody = OTPBody(phone: '');
  final RegisterBody _regBody = RegisterBody(firstName: '', lastName: '', mobile: '', confirmPassword: '', password: '', email: '');

  ///getters
  LoginBody get body => _body;
  OTPBody get otpBody => _otpBody;
  RegisterBody get regBody => _regBody;






  ///calling APIs Functions
  Future<ResponseModel> login(String phone, String password,context) async {
    emit(LoginLoadingState()) ;
    // if(authType=='login'){
    //   _assignLoginBody(phoneController.text, otp);
    // }else{
    //   _assignLoginBody(regPhoneController.text, otp);
    // }
    _assignLoginBody(phoneController.text, password);

    ResponseModel responseModel = await _signInUseCase.call(loginBody: body);
    if (responseModel.isSuccess) {
      UserModel registerModel =responseModel.data;
      LoginModelData userModel = registerModel.data??LoginModelData();
      String token = userModel.token??'';
      if (token.isNotEmpty) {
        await _saveUserDataUseCase.call(token: token);
      }
      await BlocProvider.of<LocalAuthCubit>(context,listen: false).userLoginSuccessfully();
      phoneController.text='';
      passwordController.text='';

      if(authType=='login'){
        NavigationService.pushReplacement(Routes.layoutScreen,arguments: {'currentPage':0});
      }else{
        changeType('res_data');
      }
      emit(LoginSuccessState()) ;
    }else{
      emit(LoginErrorState(responseModel.error)) ;
    }
    return responseModel;
  }
  RestaurantTypesModel? restaurantTypesModel;
  Future<ResponseModel> getRestaurantCategories() async {
    emit(GetRestaurantCategoriesLoadingState()) ;
    ResponseModel responseModel = await _restaurantTypesUseCase.call();
    if (responseModel.isSuccess) {
      restaurantTypesModel=responseModel.data;
      emit(GetRestaurantCategoriesSuccessState()) ;
    }else{
      emit(GetRestaurantCategoriesErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel?> completeProfile(BuildContext context, bool? isUpdate) async {
    emit(CompleteProfileLoadingState()) ;
    if(comNameArController.text.isNotEmpty&&comNameController.text.isNotEmpty){
      CompleteProfileBody completeProfileBody =
      CompleteProfileBody(name: comNameController.text,
          address: comAddressController.text, type: comTypeController.text, image: imageFile, nameAr: comNameArController.text, lat: addressModel?.lat??'', long: addressModel?.long??'');
      ResponseModel responseModel = await _completeProfileUseCase.call(body: completeProfileBody);
      if (responseModel.isSuccess) {

        comEmailController.text='';
        comAddressController.text='';
        comNameController.text='';
        comNameArController.text='';
        comPhoneController.text='';
        pickUpController.text='المنطقة/المدينة/البلدة/الشارع';
        comTypeController.text='';
        imageFile=null;
        Future.delayed(const Duration(minutes: 0)).then((value) {
          if(isUpdate==true){
            context.pop();
            ProfileCubit.get(context).getProfile();
          }else{
            context.pushNamed(Routes.storeTimeScreen,arguments: {'isComplete':true});
          }
          // context.pushNamed(Routes.layoutScreen,arguments: {'currentPage':0});
        });
        emit(CompleteProfileSuccessState()) ;
      }else{
        emit(CompleteProfileErrorState()) ;
      }
      return responseModel;
    }
    else{
      showToast(text: 'اكمل البيانات', state: ToastStates.error, context: context);
      return null;
    }
  }
  void removeCompleteDate(BuildContext context){
    comEmailController.text='';
    comAddressController.text='';
    comNameController.text='';
    comNameArController.text='';
    comPhoneController.text='';
    comTypeController.text='';
    imageFile=null;
    emit(RemoveDateState()) ;
  }
  Future<ResponseModel?> otpCode({required String phone,required BuildContext context}) async {
    emit(OtpLoadingState()) ;
    try{
      _assignOtpBody(phone);
      ResponseModel responseModel = await _otpUseCase.call(body: otpBody);
      if(responseModel.data!=null){
        AuthModel otpModel =responseModel.data;
        if (responseModel.isSuccess) {
          Future.delayed(const Duration(microseconds: 0)).then((value) {
            showToast(text: otpModel.data!.otp!.toString(), state: ToastStates.success,
                context: context,gravity: ToastGravity.TOP,timeInSecForIosWeb: 250);
          });
          changeType('otp');
          changeAuthType('login');
          emit(OtpSuccessState()) ;
        }else{
          log('error', '${otpModel.toJson()}');
          log('error', '${responseModel.message}');
          emit(OtpErrorState()) ;
        }
      }
    }catch (e){
      emit(OtpErrorState()) ;
    }
    emit(OtpSuccessState()) ;
    return null;
  }


  Future<ResponseModel?> register(context) async {
    emit(RegisterLoadingState()) ;
    try{
      // changeAuthType('register');
      _assignRegisterBody(firstName: regFirstNameController.text,
          lastName:  regLastNameController.text, phone: regPhoneController.text, password: regPasswordController.text, confirmPassword: confirmPasswordController.text, email: regEmailController.text);
      ResponseModel responseModel = await _registerUseCase.call(body: regBody);
      RegisterModel registerModel =responseModel.data;
      if(responseModel.data!=null){
        if (responseModel.isSuccess) {
          // showToast(text: registerModel.data!.otp.toString(), state: ToastStates.success,
          //     context: context,gravity: ToastGravity.TOP,timeInSecForIosWeb: 250);
          // changeType('otp');
          print('---------------------------');

          LoginModelData userModel = registerModel.data??LoginModelData();
          String token = userModel.token??'';
          if (token.isNotEmpty) {
            await _saveUserDataUseCase.call(token: token);
            // context.pushNamed(Routes.completeProfileScreen);
            Navigator.push(context, MaterialPageRoute(builder: (context) =>CompleteProfileFirstScreen()));
          }
          regPhoneController.text='';
          regLastNameController.text='';
          regFirstNameController.text='';
          regPasswordController.text='';
          confirmPasswordController.text='';
          regEmailController.text='';
          emit(RegisterSuccessState()) ;
        }else{
          emit(RegisterErrorState()) ;
        }
      }else{
      }
      emit(RegisterSuccessState()) ;
      return responseModel;
    }catch (e){
      emit(RegisterErrorState()) ;
    }
    emit(RegisterErrorState()) ;
    return null;
  }




  void _assignRegisterBody({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String confirmPassword,
    required String email,

  }) {
    regBody.setData(firstName: firstName, lastName: lastName, phone: phone, password: password, confirmPassword: confirmPassword, email: email);
  }

  void _assignLoginBody(String phone,String password) {
    body.setData(phone: phone, password: password);
  }
  void _assignOtpBody(String phone) {
    otpBody.setData(phone: phone);
  }


}
