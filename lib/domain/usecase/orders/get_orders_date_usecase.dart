import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/orders_model.dart';
import '../../repository/orders_repo.dart';
import '../../request_body/accept_order_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetOrdersByDateUseCase implements BaseUseCase<dynamic>{
  final OrdersRepository repository;
  GetOrdersByDateUseCase({required this.repository});
  Future<ResponseModel> call({required String date}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.getOrderByDate(date:date),
        onConvert,tag: 'GetOrdersByDateUseCase');
  }

  @override
  ResponseModel<dynamic> onConvert(BaseModel baseModel) {
    try{
      OrdersModel ordersModel =OrdersModel.fromJson(baseModel.item);
      if(baseModel.code =='200' ||baseModel.code =='201'){
        return ResponseModel(baseModel.status??true, baseModel.message,data: ordersModel);
      }else{
        return ResponseModel(baseModel.status??false, baseModel.message,data: ordersModel);
      }
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
