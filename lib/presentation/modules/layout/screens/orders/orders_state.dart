part of 'orders_cubit.dart';

 class OrdersState extends Equatable {
  final RequestState paddingState;
  final RequestState completeState;
  final RequestState rejectedState;
  final RequestState onWayState;
  final RequestState acceptOrderState;
  final RequestState onProgressOrdersState;
  final List<OrdersModelData> paddingOrdersList;
  final List<OrdersModelData> completeOrdersList;
  final List<OrdersModelData> onWayOrdersList;
  final List<OrdersModelData> rejectedOrdersList;
  final List<OrdersModelData> onProgressOrdersList;
  final List<OrdersModelData> acceptOrdersList;
  final int acceptPage;
  final int completePage;
  final int paddingPage;
  final int onProgressPage;
  final int rejectedPage;
  final int onWayPage;
  const OrdersState({
    this.paddingState = RequestState.initial,
    this.completeState = RequestState.initial,
    this.rejectedState = RequestState.initial,
    this.onProgressOrdersState = RequestState.initial,
    this.acceptOrderState = RequestState.initial,
    this.onWayState = RequestState.initial,
    this.paddingPage=1,
    this.completePage=1,
    this.acceptPage=1,
    this.rejectedPage=1,
    this.onProgressPage=1,
    this.onWayPage=1,
    this.paddingOrdersList = const [],
    this.acceptOrdersList = const [],
    this.onWayOrdersList = const [],
    this.rejectedOrdersList = const [],
    this.completeOrdersList = const [],
    this.onProgressOrdersList = const [],
  });

  OrdersState copyWith({
    RequestState? paddingState,
    RequestState? onWayState,
    RequestState? rejectedState,
    RequestState? onProgressState,
    RequestState? acceptOrderState,
    RequestState? completeState,
    int? acceptPage,
    int? paddingPage,
    int? rejectedPage,
    int? onWayPage,
    int? completePage,
    int? onProgressPage,
    List<OrdersModelData>? paddingOrdersList,
    List<OrdersModelData>? onWayOrdersList,
    List<OrdersModelData>? rejectedOrdersList,
    List<OrdersModelData>? completeOrdersList,
    List<OrdersModelData>? onProgressOrdersList,
    List<OrdersModelData>? acceptOrdersList,
  }) {
    return OrdersState(
      paddingState: paddingState ?? this.paddingState,
      rejectedState: rejectedState ?? this.rejectedState,
      completeState: completeState ?? this.completeState,
      onProgressOrdersState: onProgressState ?? this.onProgressOrdersState,
      onWayState: onWayState ?? this.onWayState,
      acceptOrderState: acceptOrderState ?? this.acceptOrderState,
      paddingPage: paddingPage ?? this.paddingPage,
      onWayPage: onWayPage ?? this.onWayPage,
      completePage: completePage ?? this.completePage,
      onProgressPage: onProgressPage ?? this.onProgressPage,
      rejectedPage: rejectedPage ?? this.rejectedPage,
      acceptPage: acceptPage ?? this.acceptPage,
      paddingOrdersList: paddingOrdersList ?? this.paddingOrdersList,
      onProgressOrdersList: onProgressOrdersList ?? this.onProgressOrdersList,
      acceptOrdersList: acceptOrdersList ?? this.acceptOrdersList,
      onWayOrdersList: onWayOrdersList ?? this.onWayOrdersList,
      completeOrdersList: completeOrdersList ?? this.completeOrdersList,
      rejectedOrdersList: rejectedOrdersList ?? this.rejectedOrdersList,
    );
  }



  @override
  List<Object> get props => [
    paddingState, paddingOrdersList, paddingPage,
    acceptPage,acceptOrderState,acceptOrdersList,
    onWayState,onWayOrdersList,onWayPage,
    onProgressOrdersState,onProgressOrdersList,onProgressPage,
    completeState,completeOrdersList,completePage,
    rejectedState,rejectedOrdersList,rejectedPage,
  ];
}

final class OrdersInitial extends OrdersState {}
final class GetAllOrderLoadingState extends OrdersState {}
final class GetAllOrderSuccessState extends OrdersState {}
final class GetAllOrderErrorState extends OrdersState {}

final class AcceptOrderLoadingState extends OrdersState {}
final class AcceptOrderSuccessState extends OrdersState {}
final class AcceptOrderErrorState extends OrdersState {}

final class RejectOrderLoadingState extends OrdersState {}
final class RejectOrderSuccessState extends OrdersState {}
final class RejectOrderErrorState extends OrdersState {}

final class ChangeRestaurantLoadingState extends OrdersState {}
final class ChangeRestaurantSuccessState extends OrdersState {}
final class ChangeRestaurantErrorState extends OrdersState {}
