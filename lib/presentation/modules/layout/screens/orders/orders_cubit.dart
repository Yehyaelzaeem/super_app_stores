import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/utils/toast_states/enums.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/orders_model.dart';
import '../../../../../domain/request_body/accept_order_body.dart';
import '../../../../../domain/usecase/orders/accept_order_usecase.dart';
import '../../../../../domain/usecase/orders/get_orders_usecase.dart';
import '../../../../../domain/usecase/orders/reject_order_usecase.dart';
import '../../../branches/branch_cubit.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final RejectOrderUseCase _rejectOrderUseCase;
  final AcceptOrderUseCase _acceptOrderUseCase;
  OrdersCubit({required GetOrdersUseCase getOrdersUseCase,required AcceptOrderUseCase acceptOrderUseCase,required RejectOrderUseCase rejectOrderUseCase}) :
      _getOrdersUseCase=getOrdersUseCase,
      _acceptOrderUseCase=acceptOrderUseCase,
      _rejectOrderUseCase=rejectOrderUseCase,
        super(OrdersInitial());

  static OrdersCubit get()=>BlocProvider.of(NavigationService.navigationKey.currentContext!);
  OrdersModel? ordersModel;
  Future<ResponseModel> getAllOrders() async {
    emit(GetAllOrderLoadingState()) ;
    ResponseModel responseModel = await _getOrdersUseCase.call();
    if (responseModel.isSuccess) {
      ordersModel =responseModel.data;
      emit(GetAllOrderSuccessState()) ;
    }else{
      emit(GetAllOrderErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> acceptOrder({required int orderId}) async {
    emit(AcceptOrderLoadingState()) ;
    BranchCubit cubit =BranchCubit.get();
    AcceptOrderBody acceptOrderBody=AcceptOrderBody(
      orderId: orderId,
      lat:cubit.lat??0.0 ,
      long:cubit.long??0.0,
    );
    ResponseModel responseModel = await _acceptOrderUseCase.call(acceptOrderBody: acceptOrderBody);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
       getAllOrders();
      });
      emit(AcceptOrderSuccessState()) ;
    }else{
      emit(AcceptOrderErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> rejectOrder({required int orderId}) async {
    emit(RejectOrderLoadingState()) ;
    ResponseModel responseModel = await _rejectOrderUseCase.call(orderId: orderId);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
       getAllOrders();
      });
      emit(RejectOrderSuccessState()) ;
    }else{
      emit(RejectOrderErrorState()) ;
    }
    return responseModel;
  }




}
