part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

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
