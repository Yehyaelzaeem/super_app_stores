import 'dart:async';
import 'package:cogina_restaurants/domain/request_body/accept_order_body.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/favorite_repo.dart';
import '../../domain/repository/orders_repo.dart';
import '../../presentation/modules/branches/branch_cubit.dart';
import '../../presentation/modules/layout/screens/orders/orders_cubit.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class OrdersRepositoryImp implements OrdersRepository{
  final DioClient _dioClient;

  OrdersRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;
  String? branchId;
  @override
  Future<ApiResponse> getAllOrders({required String status,required int page, required String branchId}) async{
    try {
      Response response = await _dioClient.get(
          AppURL.kAllOrdersURL(status: status,page: page, branchId:branchId),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> acceptOrder({required AcceptOrderBody acceptOrderBody})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kAcceptOrderURL,
        queryParameters: acceptOrderBody.toJson()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> rejectOrder({required int orderId}) async{
    try {
      Response response = await _dioClient.post(
        AppURL.kRejectOrderURL(id: orderId),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> changeStateRestaurant()async {
    try {
      Response response = await _dioClient.post(
        AppURL.kChangeRestaurantStateURL,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getOrderByDate({required String date}) async{
    try {
      Response response = await _dioClient.get(
        AppURL.kGetOrdersByDateStateURL(date: date),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> deliveredOrder({required int orderId,})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kDeliveredOrderURL(id: orderId),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> finishOrder({required int orderId}) async{
    try {
      Response response = await _dioClient.post(
        AppURL.kFinishOrderURL(id: orderId),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> inProgressOrder({required int orderId})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kInProgressOrderURL(id: orderId),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
