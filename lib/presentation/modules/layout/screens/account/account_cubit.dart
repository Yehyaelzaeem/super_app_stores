import 'dart:io';

import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/domain/request_body/account_files_body.dart';
import 'package:cogina_restaurants/domain/request_body/bank_account_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/toast_states/enums.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/more_contact_us_model.dart';
import '../../../../../domain/usecase/account/about_us_usecase.dart';
import '../../../../../domain/usecase/account/add_account_file_usecase.dart';
import '../../../../../domain/usecase/account/bank_account_usecase.dart';
import '../../../../../domain/usecase/account/privacy_usecase.dart';
import '../../../../../domain/usecase/account/terms_usecase.dart';
import 'edit_profile/profile_cubit.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AboutUsUseCase _aboutUsUseCase;
  final PrivacyUseCase _privacyUseCase;
  final TermsUseCase _termsUseCase;
  final BankAccountUseCase _bankAccountUseCase;
  final AddAccountFilesUseCase _addAccountFilesUseCase;
  AccountCubit({
    required BankAccountUseCase bankAccountUseCase,
    required AboutUsUseCase aboutUsUseCase,
    required PrivacyUseCase privacyUseCase,
    required TermsUseCase termsUseCase,
    required AddAccountFilesUseCase addAccountFilesUseCase}) :
        _aboutUsUseCase =aboutUsUseCase,_privacyUseCase=privacyUseCase,_termsUseCase=termsUseCase,
        _bankAccountUseCase=bankAccountUseCase,_addAccountFilesUseCase=addAccountFilesUseCase, super(AccountInitial());

  static AccountCubit get(BuildContext context)=>BlocProvider.of(context);

  TextEditingController holderName =TextEditingController();
  TextEditingController bankName =TextEditingController();
  TextEditingController accountNumber =TextEditingController();
  TextEditingController branchName =TextEditingController();
  TextEditingController iban =TextEditingController();
  final bankKey = GlobalKey<FormState>();

  Future<dynamic> bankAccount(BuildContext context) async {
    if(bankKey.currentState!.validate()){
      emit(BankAccountLoadingState()) ;
      BankAccountBody bankAccountBody =BankAccountBody(
          holderName: holderName.text, bankName: bankName.text,
          accountNumber: accountNumber.text, bankBranch: branchName.text,
          iban: iban.text);
      ResponseModel responseModel = await _bankAccountUseCase.call(bankAccountBody: bankAccountBody);
      if (responseModel.isSuccess) {
        Future.delayed(const Duration(microseconds: 0)).then((value) {
          showToast(text: responseModel.message.toString(), state: ToastStates.success, context: context);
          removeData();
          ProfileCubit.get(context).getProfile();
          context.pop();
        });
        emit(BankAccountSuccessState()) ;
      }else{
        emit(BankAccountErrorState());
      }
    }
  }
  Future<dynamic> uploadAccountFile({required BuildContext context,required String type}) async {
    emit(UploadFileLoadingState()) ;
    AccountFilesBody accountFilesBody =
    type=='commercialIdFile'?
    AccountFilesBody(commercialFile: commercialIdFile,):
    type=='taxFile'? AccountFilesBody(taxFile: taxFile ): AccountFilesBody(bannerFile:bannerFile );
    ResponseModel responseModel = await _addAccountFilesUseCase.call(accountFilesBody: accountFilesBody);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: context);
        ProfileCubit.get(context).getProfile();
        context.pop();
      });
      emit(UploadFileLSuccessState()) ;
    }else{
      emit(UploadFileErrorState());
    }
  }

  MoreContactUsModel? aboutUsData;
  MoreContactUsModel? privacyData;
  MoreContactUsModel? termsData;
  Future<ResponseModel> getAboutUs() async {
    aboutUsData=null;
    emit(GetDataLoadingState()) ;
    ResponseModel responseModel = await _aboutUsUseCase.call();
    if (responseModel.isSuccess) {
      MoreContactUsModel moreContactUsModel=responseModel.data;
      emit(GetDataSuccessState(data: moreContactUsModel.data.toString())) ;
    }else{
      emit(GetDataErrorState()) ;
    }
    return responseModel;
  }
  Future<ResponseModel> getPrivacy() async {
    privacyData=null;
    emit(GetDataLoadingState()) ;
    ResponseModel responseModel = await _privacyUseCase.call();
    if (responseModel.isSuccess) {
      MoreContactUsModel moreContactUsModel=responseModel.data;
      emit(GetDataSuccessState(data: moreContactUsModel.data!.toString())) ;
    }else{
      emit(GetDataErrorState()) ;
    }
    return responseModel;
  }
  Future<ResponseModel> getTerms() async {
    termsData=null;
    emit(GetDataLoadingState()) ;
    ResponseModel responseModel = await _termsUseCase.call();
    if (responseModel.isSuccess) {
      MoreContactUsModel moreContactUsModel=responseModel.data;
      emit(GetDataSuccessState(data:  moreContactUsModel.data!.toString())) ;
    }else{
      emit(GetDataErrorState()) ;
    }
    return responseModel;
  }
  void passAccountData(BuildContext context){
    ProfileCubit cubit=  ProfileCubit.get(context);
    var data =cubit.profileModel!.bankAccount!;
    holderName.text=data.holderName!;
    bankName.text=data.bankName!;
    accountNumber.text=data.accountNumber!;
    branchName.text=data.bankBranch!;
    iban.text=data.iban!;
    emit(PassAccountDataState()) ;
  }
  void removeData(){
    holderName.text='';
    bankName.text='';
    accountNumber.text='';
    branchName.text='';
    iban.text='';
    emit(RemoveAccountDataState()) ;
  }

  File? commercialIdFile;
  File? taxFile;
  File? bannerFile;
  Future<void> pickImage({required String type}) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if(type=='commercialIdFile'){
        commercialIdFile=File(image.path);
      }else if (type=='taxFile'){
        taxFile=File(image.path);
      }
      else if (type=='bannerFile'){
        bannerFile=File(image.path);
      }
    }
    emit(PickImageState());
  }
}
