import 'package:bloc/bloc.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/utils/toast_states/enums.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/orders_model.dart';
import '../../../../../domain/request_body/accept_order_body.dart';
import '../../../../../domain/usecase/orders/accept_order_usecase.dart';
import '../../../../../domain/usecase/orders/change_state_restaurant_usecase.dart';
import '../../../../../domain/usecase/orders/get_orders_date_usecase.dart';
import '../../../../../domain/usecase/orders/get_orders_usecase.dart';
import '../../../../../domain/usecase/orders/reject_order_usecase.dart';
import '../../../branches/branch_cubit.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final RejectOrderUseCase _rejectOrderUseCase;
  final AcceptOrderUseCase _acceptOrderUseCase;
  final GetOrdersByDateUseCase _getOrdersByDateUseCase;
  final ChangeStateRestaurantUseCase _changeStateRestaurantUseCase;
  OrdersCubit({required ChangeStateRestaurantUseCase changeStateRestaurantUseCase,
    required GetOrdersByDateUseCase getOrdersByDateUseCase,required GetOrdersUseCase getOrdersUseCase,required AcceptOrderUseCase acceptOrderUseCase,required RejectOrderUseCase rejectOrderUseCase}) :
      _getOrdersUseCase=getOrdersUseCase,
      _getOrdersByDateUseCase=getOrdersByDateUseCase,
      _changeStateRestaurantUseCase=changeStateRestaurantUseCase,
      _acceptOrderUseCase=acceptOrderUseCase,
      _rejectOrderUseCase=rejectOrderUseCase,
        super(OrdersInitial());

  static OrdersCubit get()=>BlocProvider.of(NavigationService.navigationKey.currentContext!);
  OrdersModel? ordersModel;
  OrdersModel? ordersByDate;
  bool switchValue = true;
  void switchState(bool x){
    switchValue=x;
    emit(GetAllOrderLoadingState()) ;
  }
  Future<ResponseModel> getAllOrders() async {
    ordersModel=null;
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
  Future<ResponseModel> getOrdersByDate({required String date}) async {
    ordersByDate=null;
    emit(GetAllOrderLoadingState()) ;
    ResponseModel responseModel = await _getOrdersByDateUseCase.call(date: date);
    if (responseModel.isSuccess) {
      print(responseModel.data!.toString());
      ordersByDate =responseModel.data!;
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
  Future<ResponseModel> changeStateRestaurant() async {
    emit(ChangeRestaurantLoadingState()) ;
    ResponseModel responseModel = await _changeStateRestaurantUseCase.call();
    if (responseModel.isSuccess) {
      ProfileCubit.get(NavigationService.navigationKey.currentContext!).getProfile();
      emit(ChangeRestaurantSuccessState()) ;
    }else{
      emit(ChangeRestaurantErrorState()) ;
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
