import 'dart:async';
import 'package:cogina_restaurants/data/model/response/delivery_time.dart';
import 'package:cogina_restaurants/data/model/response/time_params.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/favorite_repo.dart';
import '../../domain/repository/store_time_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class StoreTimeRepositoryImp implements StoreTimeRepository{
  final DioClient _dioClient;
  const StoreTimeRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  @override
  Future<ApiResponse> addStoreTime({required TimeParams params}) async{
    try {
      Response response = await _dioClient.post(
          AppURL.kAddStoreTimeURL,
          queryParameters: params.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addDeliveryTime({required DeliveryTimeParams params})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kAddDeliveryTimeURL,
        queryParameters: params.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
