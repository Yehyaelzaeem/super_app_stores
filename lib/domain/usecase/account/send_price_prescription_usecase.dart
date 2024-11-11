
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/more_contact_us_model.dart';
import '../../../data/model/response/prescription_model.dart';
import '../../../data/model/response/send_prescription_params.dart';
import '../../repository/account_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class SendPricePrescriptionUseCase implements BaseUseCase<dynamic>{
  final AccountRepository repository;
  SendPricePrescriptionUseCase({required this.repository});
  Future<ResponseModel> call({required SendPrescriptionParams sendPrescriptionParams}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.sendPricePrescription(sendPrescriptionParams: sendPrescriptionParams), onConvert,tag: 'SendPricePrescriptionUseCase');
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
