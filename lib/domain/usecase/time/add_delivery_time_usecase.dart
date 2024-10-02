import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/delivery_time.dart';
import '../../../data/model/response/time_params.dart';
import '../../repository/favorite_repo.dart';
import '../../repository/store_time_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class AddDeliveryTimeUseCase implements BaseUseCase<dynamic>{
  final StoreTimeRepository repository;
  AddDeliveryTimeUseCase({required this.repository});
  Future<ResponseModel> call({required DeliveryTimeParams params}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.addDeliveryTime(params: params), onConvert,tag: 'AddDeliveryTimeUseCase');
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
