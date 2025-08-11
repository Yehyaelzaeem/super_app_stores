import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/otp_model.dart';
import '../../../data/model/response/register_model.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/register_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase{

  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<ResponseModel> call({ required RegisterBody body}) async {
    return BaseUseCaseCall.onGetData( await repository.register(registerBody: body), onConvert,tag: 'RegisterUseCase');
  }

  @override
  ResponseModel onConvert(BaseModel baseModel) {
    try{
      return ResponseModel(baseModel.status??true, baseModel.message, data: baseModel.data);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.data);
    }
  }


}
