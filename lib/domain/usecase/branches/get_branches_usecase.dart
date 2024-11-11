import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/branches_model.dart';
import '../../../data/model/response/profile_model.dart';
import '../../repository/branches_repo.dart';
import '../../repository/profile_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetBranchesUseCase implements BaseUseCase<BranchesModel>{
  final BranchesRepository repository;
  GetBranchesUseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<BranchesModel>( await repository.getBranches(), onConvert,tag: 'BranchesUseCase');
  }

  @override
  ResponseModel<BranchesModel> onConvert(BaseModel baseModel) {
    BranchesModel? branchesModel = BranchesModel.fromJson(baseModel.item);
    try{
      return ResponseModel(baseModel.status??true, baseModel.message,data: branchesModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
