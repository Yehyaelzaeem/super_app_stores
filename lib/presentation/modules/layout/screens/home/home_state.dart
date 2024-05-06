part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetProductLoadingState extends HomeState {}
class GetProductCategoriesLoadingState extends HomeState {}
class GetProductSuccessState extends HomeState {}
class GetProductCategoriesSuccessState extends HomeState {}
class GetProductCategoriesErrorState extends HomeState {}
class GetProductErrorState extends HomeState {}
class UpdateProductLoadingState extends HomeState {}
class AddProductLoadingState extends HomeState {}
class UpdateProductSuccessState extends HomeState {}
class AddProductSuccessState extends HomeState {}
class AddProductErrorState extends HomeState {}
class UpdateProductErrorState extends HomeState {}
class PickImageState extends HomeState {}
class RemoveDataState extends HomeState {}
class DeleteProductLoadingState extends HomeState {}
class DeleteProductSuccessState extends HomeState {}
class DeleteProductErrorState extends HomeState {}
class PushDataState extends HomeState {}
