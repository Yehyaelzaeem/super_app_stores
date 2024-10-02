import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/utils/toast_states/enums.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/orders_model.dart';
import '../../../../../domain/request_body/accept_order_body.dart';
import '../../../../../domain/usecase/orders/accept_order_usecase.dart';
import '../../../../../domain/usecase/orders/change_state_restaurant_usecase.dart';
import '../../../../../domain/usecase/orders/delivered_order_usecase.dart';
import '../../../../../domain/usecase/orders/finish_order_usecase.dart';
import '../../../../../domain/usecase/orders/get_orders_date_usecase.dart';
import '../../../../../domain/usecase/orders/get_orders_usecase.dart';
import '../../../../../domain/usecase/orders/in_progress_order_usecase.dart';
import '../../../../../domain/usecase/orders/reject_order_usecase.dart';
import '../../../branches/branch_cubit.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final RejectOrderUseCase _rejectOrderUseCase;
  final AcceptOrderUseCase _acceptOrderUseCase;
  final GetOrdersByDateUseCase _getOrdersByDateUseCase;
  final FinishOrderUseCase finishOrderUseCase;
  final InProgressOrderUseCase inProgressOrderUseCase;
  final DeliveredOrderUseCase deliveredOrderUseCase;

  final ChangeStateRestaurantUseCase _changeStateRestaurantUseCase;
  OrdersCubit( {
    required this.finishOrderUseCase, required this.inProgressOrderUseCase, required this.deliveredOrderUseCase,
    required ChangeStateRestaurantUseCase changeStateRestaurantUseCase,
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

   String? branchId;

  changeBranch(String? branchId){
    this.branchId=branchId;
    pendingOrdersList.clear();
    pendingOrders=null;
    emit(state.copyWith(paddingPage:1));
    acceptedOrdersList.clear();
    acceptedOrders=null;
    emit(state.copyWith(acceptPage:1));
    rejectedOrdersList.clear();
    rejectedOrders=null;
    emit(state.copyWith(rejectedPage:1));
    completedOrdersList.clear();
    completedOrders=null;
    emit(state.copyWith(completePage:1));
    onWayOrdersList.clear();
    onWayOrders=null;
    emit(state.copyWith(onWayPage:1));
    onProgressOrdersList.clear();
    onProgressOrders=null;
    emit(state.copyWith(onProgressPage:1));
    getPendingOrders(status: 'padding');
    getAcceptedOrders(status: 'restaurant_accepted');
    getRejectedOrders(status: 'restaurant_rejected');
    getCompletedOrders(status: 'restaurant_done');
    getOnWayOrders(status: 'restaurant_done');
    getOnProgressOrders(status: 'restaurant_order_progress');
  }
  ///Pending Orders
  bool isLoading = false;
  bool isPaginationLoading = false;
  OrdersModel? pendingOrders;
  List<OrdersModelData> pendingOrdersList=[];
  Future getPendingOrders({required String status}) async {
    if (isLoading || isPaginationLoading) return;
    if (pendingOrders != null && (pendingOrders?.meta?.pagination?.currentPage ?? 0) >= (pendingOrders?.meta?.pagination?.totalPages ?? 1)) {
      isPaginationLoading = false;
      emit(state.copyWith(paddingState: RequestState.loaded,paddingOrdersList: pendingOrdersList));
      return;
    }
    isPaginationLoading = true;
    try {
      if (pendingOrders != null) {
        emit(state.copyWith(paddingPage: state.paddingPage + 1));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: state.paddingPage,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          pendingOrders = responseModel.data;
          pendingOrdersList.addAll(pendingOrders?.data ?? []);
          isPaginationLoading = false;
          emit(state.copyWith(paddingState: RequestState.loaded, paddingOrdersList: pendingOrdersList));
        } else {
          emit(state.copyWith(paddingState: RequestState.error));
        }
      } else {
        emit(state.copyWith(paddingState: RequestState.loading));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: 1,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          pendingOrders = responseModel.data;
          pendingOrdersList.addAll(pendingOrders?.data ?? []);
          emit(state.copyWith(paddingState: RequestState.loaded, paddingOrdersList: pendingOrdersList));
        } else {
          emit(GetAllOrderErrorState());
        }
      }
    }
    finally {
      isPaginationLoading = false;
      emit(state.copyWith(paddingState: RequestState.loaded, paddingOrdersList: pendingOrdersList));
    }
  }


  ///Accepted Orders
  OrdersModel? acceptedOrders;
  List<OrdersModelData> acceptedOrdersList=[];
  bool isPaginationAcceptedLoading = false;
  Future getAcceptedOrders({required String status}) async {
    if ( isPaginationAcceptedLoading) return;
    if (acceptedOrders != null && (acceptedOrders?.meta?.pagination?.currentPage ?? 0) >= (acceptedOrders?.meta?.pagination?.totalPages ?? 1)) {
      isPaginationAcceptedLoading = false;
      emit(state.copyWith(acceptOrderState: RequestState.loaded,acceptOrdersList: acceptedOrdersList));
      return;
    }
    isPaginationAcceptedLoading = true;
    try {
      if (acceptedOrders != null) {
        emit(state.copyWith(acceptPage: state.acceptPage + 1));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: state.acceptPage,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          acceptedOrders = responseModel.data;
          acceptedOrdersList.addAll(acceptedOrders?.data ?? []);
          emit(state.copyWith(acceptOrderState: RequestState.loaded, acceptOrdersList: acceptedOrdersList));
        } else {
          emit(state.copyWith(acceptOrderState: RequestState.error));
        }
      }
      else {
        emit(state.copyWith(acceptOrderState: RequestState.loading));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: 1,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          acceptedOrders = responseModel.data;
          acceptedOrdersList.addAll(acceptedOrders?.data ?? []);
          emit(state.copyWith(acceptOrderState: RequestState.loaded, acceptOrdersList: acceptedOrdersList));
        } else {
          emit(GetAllOrderErrorState());
        }
      }
    }
    finally {
      isPaginationAcceptedLoading = false;
    }
  }

  ///Rejected Orders
  OrdersModel? rejectedOrders;
  List<OrdersModelData> rejectedOrdersList=[];
  bool isPaginationRejectedLoading = false;

  Future getRejectedOrders({required String status}) async {

    if ( isPaginationRejectedLoading) return;
    if (rejectedOrders != null && (rejectedOrders?.meta?.pagination?.currentPage ?? 0) >= (rejectedOrders?.meta?.pagination?.totalPages ?? 1)) {
      isPaginationRejectedLoading = false;
      emit(state.copyWith(rejectedState: RequestState.loaded,rejectedOrdersList: rejectedOrdersList));
      return;
    }
    isPaginationRejectedLoading = true;
    try {
      if (rejectedOrders != null) {
        emit(state.copyWith(rejectedPage: state.rejectedPage + 1));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: state.rejectedPage,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          rejectedOrders = responseModel.data;
          rejectedOrdersList.addAll(rejectedOrders?.data ?? []);
          emit(state.copyWith(rejectedState: RequestState.loaded, rejectedOrdersList: rejectedOrdersList));
          print('rejectedOrdersadsafdfdsasList ${state.rejectedOrdersList.length}');

        } else {
          emit(state.copyWith(rejectedState: RequestState.error));
        }
      }
      else {
        emit(state.copyWith(rejectedState: RequestState.loading));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: 1,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          rejectedOrders = responseModel.data;
          rejectedOrdersList.addAll(rejectedOrders?.data ?? []);
          emit(state.copyWith(rejectedState: RequestState.loaded, rejectedOrdersList: rejectedOrdersList));
        } else {
          emit(GetAllOrderErrorState());
        }
      }
    }
    finally {
      isPaginationRejectedLoading = false;
    }
    emit(state.copyWith(rejectedState: RequestState.loaded, rejectedOrdersList: rejectedOrdersList));

  }


  ///Completed Orders
  OrdersModel? completedOrders;
  List<OrdersModelData> completedOrdersList=[];
  bool isPaginationCompletedLoading = false;

  Future getCompletedOrders({required String status}) async {
    if ( isPaginationCompletedLoading) return;
    if (completedOrders != null && (completedOrders?.meta?.pagination?.currentPage ?? 0) >= (completedOrders?.meta?.pagination?.totalPages ?? 1)) {
      isPaginationCompletedLoading = false;
      emit(state.copyWith(completeState: RequestState.loaded,completeOrdersList: completedOrdersList));
      return;
    }
    isPaginationCompletedLoading = true;
    try {
      if (completedOrders != null) {
        emit(state.copyWith(completePage: state.completePage + 1));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: state.completePage,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          completedOrders = responseModel.data;
          completedOrdersList.addAll(completedOrders?.data ?? []);
          emit(state.copyWith(completeState: RequestState.loaded, completeOrdersList: completedOrdersList));
        } else {
          emit(state.copyWith(completeState: RequestState.error));
        }
      }
      else {
        emit(state.copyWith(completeState: RequestState.loading));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: 1,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          completedOrders = responseModel.data;
          completedOrdersList.addAll(completedOrders?.data ?? []);
          emit(state.copyWith(completeState: RequestState.loaded, completeOrdersList: completedOrdersList));
        } else {
          emit(GetAllOrderErrorState());
        }
      }
    }
    finally {
      isPaginationCompletedLoading = false;
    }
  }

  ///On Way Orders
  OrdersModel? onWayOrders;
  List<OrdersModelData> onWayOrdersList=[];
  bool isPaginationOnWayLoading = false;

  Future getOnWayOrders({required String status}) async {
    if ( isPaginationOnWayLoading) return;
    if (onWayOrders != null && (onWayOrders?.meta?.pagination?.currentPage ?? 0) >= (onWayOrders?.meta?.pagination?.totalPages ?? 1)) {
      isPaginationOnWayLoading = false;
      emit(state.copyWith(onWayState: RequestState.loaded,onWayOrdersList: onWayOrdersList));
      return;
    }
    isPaginationOnWayLoading = true;
    try {
      if (onWayOrders != null) {
        emit(state.copyWith(onWayPage: state.onWayPage + 1));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: state.onWayPage,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          onWayOrders = responseModel.data;
          onWayOrdersList.addAll(onWayOrders?.data ?? []);
          emit(state.copyWith(onWayState: RequestState.loaded, onWayOrdersList: onWayOrdersList));
        } else {
          emit(state.copyWith(onWayState: RequestState.error));
        }
      }
      else {
        emit(state.copyWith(onWayState: RequestState.loading));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: 1,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          onWayOrders = responseModel.data;
          onWayOrdersList.addAll(onWayOrders?.data ?? []);
          emit(state.copyWith(onWayState: RequestState.loaded, onWayOrdersList: onWayOrdersList));
        } else {
          emit(GetAllOrderErrorState());
        }
      }
    }
    finally {
      isPaginationOnWayLoading = false;
    }
  }


  ///On Progress Orders
  OrdersModel? onProgressOrders;
  List<OrdersModelData> onProgressOrdersList=[];
    bool isPaginationOnProgressLoading = false;
  Future getOnProgressOrders({required String status}) async {
    if ( isPaginationOnProgressLoading) return;
    if (onProgressOrders != null && (onProgressOrders?.meta?.pagination?.currentPage ?? 0) >= (onProgressOrders?.meta?.pagination?.totalPages ?? 1)) {
      isPaginationOnProgressLoading = false;
      emit(state.copyWith(onProgressState: RequestState.loaded,onProgressOrdersList: onProgressOrdersList));
      return;
    }
    isPaginationOnProgressLoading = true;
    try {
      if (onProgressOrders != null) {
        emit(state.copyWith(onProgressPage: state.onProgressPage + 1));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: state.onProgressPage,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          onProgressOrders = responseModel.data;
          onProgressOrdersList.addAll(onProgressOrders?.data ?? []);
          emit(state.copyWith(onProgressState: RequestState.loaded, onProgressOrdersList: onProgressOrdersList));
        } else {
          emit(state.copyWith(onProgressState: RequestState.error));
        }
      }
      else {
        emit(state.copyWith(onProgressState: RequestState.loading));
        ResponseModel responseModel = await _getOrdersUseCase.call(status: status, page: 1,branchId: branchId??'0');
        if (responseModel.isSuccess) {
          onProgressOrders = responseModel.data;
          onProgressOrdersList.addAll(onProgressOrders?.data ?? []);
          emit(state.copyWith(onProgressState: RequestState.loaded, onProgressOrdersList: onProgressOrdersList));
        } else {
          emit(GetAllOrderErrorState());
        }
      }
    }
    finally {
      isPaginationOnProgressLoading = false;
    }
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
        pendingOrders=null;
        pendingOrdersList.clear();
        emit(state.copyWith(paddingPage:1));
        getPendingOrders(status: 'padding');

      });
      emit(RejectOrderSuccessState()) ;
    }else{
      emit(RejectOrderErrorState()) ;
    }
    return responseModel;
  }


///Access Orders
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
        pendingOrders=null;
        pendingOrdersList.clear();
        emit(state.copyWith(paddingPage:1));
        getPendingOrders(status: 'padding');
      });
      emit(AcceptOrderSuccessState()) ;
    }else{
      emit(AcceptOrderErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> inProgressOrder({required int orderId}) async {
    emit(AcceptOrderLoadingState());
    ResponseModel responseModel = await inProgressOrderUseCase.call(orderId: orderId);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
        acceptedOrders=null;
        onProgressOrders=null;
        onProgressOrdersList.clear();
        acceptedOrdersList.clear();
        emit(state.copyWith(onProgressPage:1));
        emit(state.copyWith(acceptPage:1));
        getAcceptedOrders(status: 'restaurant_accepted');
      });
      emit(AcceptOrderSuccessState()) ;
    }else{
      emit(AcceptOrderErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> finishOrder({required int orderId}) async {
    emit(AcceptOrderLoadingState());
    ResponseModel responseModel = await finishOrderUseCase.call(orderId: orderId);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
        onWayOrders=null;
        onProgressOrders=null;
        onProgressOrdersList.clear();
        onWayOrdersList.clear();
        emit(state.copyWith(onWayPage:1));
        emit(state.copyWith(onProgressPage:1));
        getOnProgressOrders(status: 'restaurant_order_progress');
      });
      emit(AcceptOrderSuccessState()) ;
    }else{
      emit(AcceptOrderErrorState()) ;
    }
    return responseModel;
  }
  Future<ResponseModel> deliveredOrder({required int orderId}) async {
    emit(AcceptOrderLoadingState());
    ResponseModel responseModel = await deliveredOrderUseCase.call(orderId: orderId);
    if (responseModel.isSuccess) {
      Future.delayed(const Duration(microseconds: 0)).then((value) {
        showToast(text: responseModel.message.toString(), state: ToastStates.success, context: NavigationService.navigationKey.currentContext!);
        onWayOrders=null;
        completedOrders=null;
        completedOrdersList.clear();
        onWayOrdersList.clear();
        emit(state.copyWith(onWayPage:1));
        emit(state.copyWith(completePage:1));
        getOnWayOrders(status: 'restaurant_done');

      });
      emit(AcceptOrderSuccessState()) ;
    }else{
      emit(AcceptOrderErrorState()) ;
    }
    return responseModel;
  }

}
