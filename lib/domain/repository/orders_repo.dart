
import 'dart:io';

import '../../data/model/base/api_response.dart';
import '../request_body/accept_order_body.dart';
import '../request_body/account_files_body.dart';
import '../request_body/bank_account_body.dart';
import '../request_body/profile_body.dart';


mixin OrdersRepository {
  Future<ApiResponse> getAllOrders({required String status,required int page, required String branchId}) ;
  Future<ApiResponse> rejectOrder({required int orderId}) ;
  Future<ApiResponse> inProgressOrder({required int orderId}) ;
  Future<ApiResponse> finishOrder({required int orderId}) ;
  Future<ApiResponse> deliveredOrder({required int orderId}) ;
  Future<ApiResponse> changeStateRestaurant() ;
  Future<ApiResponse> acceptOrder({required AcceptOrderBody acceptOrderBody}) ;
  Future<ApiResponse> getOrderByDate({required String date}) ;

}
