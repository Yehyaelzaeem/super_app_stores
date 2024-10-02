import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/time_params.dart';
import '../../repository/favorite_repo.dart';
import '../../repository/store_time_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class AddStoreTimeUseCase implements BaseUseCase<dynamic>{
  final StoreTimeRepository repository;
  AddStoreTimeUseCase({required this.repository});
  Future<ResponseModel> call({required TimeParams params}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.addStoreTime( params: params), onConvert,tag: 'AddStoreTimeUseCase');
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
