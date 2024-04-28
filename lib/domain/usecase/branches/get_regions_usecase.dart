import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/regions_model.dart';
import '../../repository/branches_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetRegionsUseCase implements BaseUseCase<RegionsModel>{
  final BranchesRepository repository;
  GetRegionsUseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<RegionsModel>( await repository.getRegions(), onConvert,tag: 'RegionsUseCase');
  }

  @override
  ResponseModel<RegionsModel> onConvert(BaseModel baseModel) {
    try{
      RegionsModel? regionsModel = RegionsModel.fromJson(baseModel.item);
      return ResponseModel(baseModel.status??true, baseModel.message,data: regionsModel);
    }
    catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
