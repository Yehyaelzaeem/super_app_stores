import 'package:cogina_restaurants/domain/logger.dart';

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/otp_model.dart';
import '../../../data/model/response/profile_model.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/otp_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class OTPUseCase implements BaseUseCase<GetProfileModelData>{

  final AuthRepository repository;
  OTPUseCase({required this.repository});
  Future<ResponseModel> call({ required OTPBody body}) async {
    return BaseUseCaseCall.onGetData<GetProfileModelData>( await repository.otpCode(otpBody: body), onConvert);
  }


  @override
  ResponseModel<GetProfileModelData> onConvert(BaseModel baseModel) {
    GetProfileModelData profileModelData = GetProfileModelData.fromJson(baseModel.data);

    try{
      return ResponseModel(baseModel.status??true, baseModel.message, data: profileModelData);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
