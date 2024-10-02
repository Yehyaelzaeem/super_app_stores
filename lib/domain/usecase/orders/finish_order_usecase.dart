import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/orders_model.dart';
import '../../repository/orders_repo.dart';
import '../../request_body/accept_order_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class FinishOrderUseCase implements BaseUseCase<dynamic>{
  final OrdersRepository repository;
  FinishOrderUseCase({required this.repository});
  Future<ResponseModel> call({required int orderId}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.finishOrder(orderId: orderId), onConvert,tag: 'FinishOrderUseCase');
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
