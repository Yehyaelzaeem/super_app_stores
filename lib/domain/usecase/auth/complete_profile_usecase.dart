import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/otp_model.dart';
import '../../../data/model/response/register_model.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/complete_profile_body.dart';
import '../../request_body/register_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class CompleteProfileUseCase implements BaseUseCase<dynamic>{

  final AuthRepository repository;

  CompleteProfileUseCase({required this.repository});

  Future<ResponseModel> call({ required CompleteProfileBody body}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.completeProfile(completeProfileBody: body), onConvert,tag: 'CompleteProfileUseCase');
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
