import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/orders_model.dart';
import '../../repository/orders_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetOrdersUseCase implements BaseUseCase<OrdersModel>{
  final OrdersRepository repository;
  GetOrdersUseCase({required this.repository});
  Future<ResponseModel> call({required String status,required int page, required String branchId}) async {
    return BaseUseCaseCall.onGetData<OrdersModel>( await repository.getAllOrders(status: status,page: page,branchId: branchId), onConvert,tag: 'GetOrdersUseCase');
  }

  @override
  ResponseModel<OrdersModel> onConvert(BaseModel baseModel) {
    OrdersModel? ordersModel = OrdersModel.fromJson(baseModel.item);
    try{
      return ResponseModel(baseModel.status??true, baseModel.message,data: ordersModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
