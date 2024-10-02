import 'dart:io';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../core/routing/navigation_services.dart';
import '../../../../../../../data/model/base/response_model.dart';
import '../../../../../../../data/model/response/profile_model.dart';
import '../../../../../../../domain/request_body/profile_body.dart';
import '../../../../../../../domain/usecase/profile/get_profile_usecase.dart';
import '../../../../../../../domain/usecase/profile/update_profile_usecase.dart';
import '../../../../../../core/routing/routes.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required GetProfileUseCase profileUseCase, required UpdateProfileUseCase updateProfileUseCase})
      :_profileUseCase= profileUseCase,_updateProfileUseCase=updateProfileUseCase,super(ProfileInitial());
  final GetProfileUseCase _profileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  static ProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  GetProfileModelData? profileModel;
  TextEditingController firstNameController =TextEditingController();
  TextEditingController lastNameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<ResponseModel> getProfile() async {
    profileModel=null;
    emit(GetProfileLoadingState()) ;
    ResponseModel responseModel = await _profileUseCase.call();
    if (responseModel.isSuccess) {
      GetProfileModel model =responseModel.data;
      profileModel=model.data;
      final context = NavigationService.navigationKey.currentContext!;
      if(profileModel!=null){
        if(profileModel?.store==null){
          context.pushNamed(Routes.completeProfileScreen);
        }
       else if(profileModel!.store?.files==null){
          context.pushNamed(Routes.myFilesScreen,arguments: {'isComplete':true});
        }
        else if(profileModel!.store?.files?.tax==null){
          context.pushNamed(Routes.myFilesScreen,arguments: {'isComplete':true});
        }
        else if(profileModel!.store?.files?.commercialId==null){
          context.pushNamed(Routes.myFilesScreen,arguments: {'isComplete':true});
        }
        else if(profileModel!.store?.files?.banner==null){
          context.pushNamed(Routes.myFilesScreen,arguments: {'isComplete':true});
        }else if(profileModel!.store?.times==null || profileModel!.store?.times?.length==0){
          context.pushNamed(Routes.storeTimeScreen,arguments: {'isComplete':true});
        }else if(profileModel!.store?.deliveryTime==null || profileModel!.store?.deliveryPrice==null || profileModel!.store?.orderTime==null){
          context.pushNamed(Routes.deliveryTimeScreen,arguments: {'isComplete':true});
        }

      }
      emit(GetProfileSuccessState()) ;
    }else{
      emit(GetProfileErrorState()) ;
    }
    return responseModel;
  }

  ///variables
  final ProfileBody _body = ProfileBody(firstName: "", lastName: "", mobile: "");

  ///getters
  ProfileBody get body => _body;

  Future<ResponseModel> updateProfile() async {
    emit(UpdateProfileLoadingState()) ;
    _assignProfileBody(firstName: firstNameController.text, lastName: lastNameController.text,mobile: phoneController.text);
    ResponseModel responseModel = await _updateProfileUseCase.call(profileBody: body);
    if (responseModel.isSuccess) {
      getProfile();
      Navigator.of(NavigationService.navigationKey.currentContext!).pop();
      emit(UpdateProfileSuccessState()) ;
    }else{
      emit(UpdateProfileErrorState()) ;
    }
    return responseModel;
  }
  Future<ResponseModel> updateImageProfile() async {
    emit(UpdateProfileLoadingState()) ;
    ResponseModel responseModel = await _updateProfileUseCase.updateImage(image: imageFile!);
    if (responseModel.isSuccess) {
      imageFile=null;
      emit(UpdateProfileSuccessState()) ;
    }else{
      emit(UpdateProfileErrorState()) ;
    }
    return responseModel;
  }

  File? imageFile;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile =File(image.path);
    }
    emit(PickImageState());
  }
  void _assignProfileBody({required String firstName,required String lastName,required String mobile}) {
    body.setData(firstName: firstName, lastName: lastName, mobile: mobile);
  }
  void pushProfileData(){
    firstNameController.text=profileModel!.firstName.toString();
    lastNameController.text=profileModel!.lastName.toString();
    phoneController.text=profileModel!.mobileNumber.toString();
    emit(PushProfileDataState());
  }

}
