import 'dart:io';
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/profile_model.dart';
import '../../repository/account_repo.dart';
import '../../repository/profile_repo.dart';
import '../../request_body/bank_account_body.dart';
import '../../request_body/profile_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class BankAccountUseCase implements BaseUseCase<dynamic>{
  final AccountRepository repository;
  BankAccountUseCase({required this.repository});
  Future<ResponseModel> call({required BankAccountBody bankAccountBody }) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.bankAccount( bankAccountBody: bankAccountBody), onConvert,tag: 'BankAccountUseCase');
  }


  @override
  ResponseModel<dynamic> onConvert(BaseModel baseModel) {
    try{
      if(baseModel.code =='200' ||baseModel.code =='201'){
        return ResponseModel(baseModel.status??true, baseModel.message,data: baseModel.item);
      }else{
        return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
      }
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }


}
