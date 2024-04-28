import 'dart:async';
import 'package:cogina_restaurants/domain/request_body/account_files_body.dart';
import 'package:cogina_restaurants/domain/request_body/bank_account_body.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/account_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class AccountRepositoryImp implements AccountRepository{
  final DioClient _dioClient;
  const AccountRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;



  @override
  Future<ApiResponse> bankAccount({required BankAccountBody bankAccountBody})async {
    try {
      Response response = await _dioClient.post(
          AppURL.kBankAccountURL,
          queryParameters: bankAccountBody.toJson()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addAccountFiles({required AccountFilesBody accountFilesBody}) async{
    FormData data ;
    if(accountFilesBody.commercialFile!=null){
      data =FormData.fromMap({
        'commercial_id': [
          await MultipartFile.fromFile(accountFilesBody.commercialFile!.path, filename: 'upload')
        ],
      });
    }
    else if(accountFilesBody.taxFile!=null){
      data =FormData.fromMap({
        'tax': [
          await MultipartFile.fromFile(accountFilesBody.taxFile!.path, filename: 'upload')
        ],
      });
    }else{
      data =FormData.fromMap({
        'banner': [
          await MultipartFile.fromFile(accountFilesBody.bannerFile!.path, filename: 'upload')
        ],
      });
    }

    try {
      Response response = await _dioClient.post(
          AppURL.kAddAccountFilesURL,
          data2: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
