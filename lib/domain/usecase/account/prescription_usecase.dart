
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/more_contact_us_model.dart';
import '../../../data/model/response/prescription_model.dart';
import '../../repository/account_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class PrescriptionUseCase implements BaseUseCase<PrescriptionModel>{
  final AccountRepository repository;
  PrescriptionUseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<PrescriptionModel>( await repository.getPrescriptions(), onConvert,tag: 'PrescriptionUseCase');
  }

  @override
  ResponseModel<PrescriptionModel> onConvert(BaseModel baseModel) {
    try{
      PrescriptionModel prescriptionModel =PrescriptionModel.fromJson(baseModel.item);

      return ResponseModel(baseModel.status??true , baseModel.message,data: prescriptionModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
