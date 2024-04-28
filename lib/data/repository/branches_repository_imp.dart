import 'dart:async';
import 'dart:io';
import 'package:cogina_restaurants/domain/request_body/add_branch_body.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/branches_repo.dart';
import '../../domain/repository/profile_repo.dart';
import '../../domain/request_body/profile_body.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class BranchesRepositoryImp implements BranchesRepository{
  final DioClient _dioClient;
  const BranchesRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  @override
  Future<ApiResponse> getBranches() async{
    try {
      Response response = await _dioClient.get(
        AppURL.kGetBranchesURL,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addBranch({required AddBranchBody addBranchBody})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kAddBranchURL,
       queryParameters:addBranchBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getRegions()async{
    try {
      Response response = await _dioClient.get(
        AppURL.kGetRegionsURL,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> deleteBranch({required int branchId}) async{
    try {
      Response response = await _dioClient.post(
        AppURL.kDeleteBranchURL(branchId: branchId),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updateBranch({required AddBranchBody addBranchBody,required int branchId}) async{
    try {
      Response response = await _dioClient.post(
        AppURL.kUpdateBranchURL(branchId: branchId),
        queryParameters:addBranchBody.toJson(),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
