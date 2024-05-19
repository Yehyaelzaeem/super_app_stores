import 'dart:async';
import 'package:cogina_restaurants/domain/request_body/accept_order_body.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/favorite_repo.dart';
import '../../domain/repository/orders_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class OrdersRepositoryImp implements OrdersRepository{
  final DioClient _dioClient;
  const OrdersRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  @override
  Future<ApiResponse> getAllOrders() async{
    try {
      Response response = await _dioClient.get(
          AppURL.kAllOrdersURL,
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
}
