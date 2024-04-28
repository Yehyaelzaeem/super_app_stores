import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/branches_model.dart';
import '../../../data/model/response/profile_model.dart';
import '../../repository/branches_repo.dart';
import '../../repository/profile_repo.dart';
import '../../request_body/add_branch_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class UpdateBranchUseCase implements BaseUseCase<dynamic>{
  final BranchesRepository repository;
  UpdateBranchUseCase({required this.repository});
  Future<ResponseModel> call({required AddBranchBody addBranchBody,required int branchId}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.updateBranch(addBranchBody: addBranchBody, branchId: branchId), onConvert,tag: 'UpdateBranchUseCase');
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
