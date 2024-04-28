import 'dart:async';
import 'package:cogina_restaurants/domain/request_body/complete_profile_body.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/auth_repo.dart';
import '../../domain/request_body/login_body.dart';
import '../../domain/request_body/otp_body.dart';
import '../../domain/request_body/register_body.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class AuthRepositoryImp implements AuthRepository{
  final DioClient _dioClient;
  const AuthRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;
  @override
  Future<ApiResponse> login({required LoginBody loginBody}) async {
    try {
      Response response = await _dioClient.post(
        AppURL.kLoginURI,
        queryParameters: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> register({required RegisterBody registerBody})  async {
    try {
      Response response = await _dioClient.post(
          AppURL.kRegisterURI,
          queryParameters: registerBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> otpCode({required OTPBody otpBody})  async {
    try {
      Response response = await _dioClient.post(AppURL.kOtpURI, queryParameters: otpBody.toJson(),);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> completeProfile({required CompleteProfileBody completeProfileBody})async {
    try {
      Response response = await _dioClient.post(AppURL.kCompleteProfileURI,
        queryParameters: completeProfileBody.toJson(),);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // @override
  // Future<ApiResponse> updateFCMToken({required String fcmToken,required String deviceType}) async {
  //   try {
  //     Response response = await _dioClient.post(AppURL.kUpdateFCMTokenURI,queryParameters: {'phone_token':fcmToken,'type':deviceType});
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

}
