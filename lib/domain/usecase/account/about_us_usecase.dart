
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/more_contact_us_model.dart';
import '../../repository/account_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class AboutUsUseCase implements BaseUseCase<String>{
  final AccountRepository repository;
  AboutUsUseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<String>( await repository.getAboutUs(), onConvert,tag: 'AboutUsUseCase');
  }

  @override
  ResponseModel<String> onConvert(BaseModel baseModel) {
    try{
      print('sssssss ${baseModel.data}');
      // MoreContactUsModel moreContactUsModel =MoreContactUsModel.fromJson(baseModel.data);
      return ResponseModel(true , baseModel.message,data:baseModel.data);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
