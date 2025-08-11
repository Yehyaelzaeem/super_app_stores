import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../model/base/error_response.dart';
import 'error_widget.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.cancel,errorMessage:
              'error');
            case DioErrorType.connectionTimeout:
              return   ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.connectTimeout,errorMessage:'error');
            case DioErrorType.receiveTimeout:
              return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.receiveTimeout,errorMessage: 'error');
            case DioErrorType.sendTimeout:
              return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.sendTimeout,errorMessage: 'error');
            case DioErrorType.unknown:
              return   ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.other,errorMessage: 'error',);
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 401:return  const ErrorModel(code:401 ,codeError: ErrorEnum.auth,errorMessage:  'Unauthorized');
                case 404:
                case 500:
                case 503:return ErrorModel(code:error.response?.statusCode??0 ,codeError:  ErrorEnum.server,errorMessage:  error.response?.statusMessage??'server');
                default:
                  ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.message != null && errorResponse.message!.isNotEmpty) {
                    log( 'default ${error.response!.data}');
                    return  errorResponse;
                  } else {
                    return  ErrorModel(code:error.response?.statusCode??0 ,codeError: ErrorEnum.otherError,errorMessage: "Failed to load data - status code: ${error.response!.statusCode}");
                  }
              }
              break;

            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              throw UnimplementedError();
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        } else {
          return const ErrorModel(code:0 ,codeError: ErrorEnum.otherError,errorMessage: "Unexpected error occured");
        }
      } on FormatException catch (e) {
        return  ErrorModel(code:0 ,codeError:  ErrorEnum.otherError,errorMessage:  e.toString());
      }catch (e){
        return  ErrorModel(code:0 ,codeError: ErrorEnum.otherError,errorMessage:  e.toString());
      }
    } else {
      return  const ErrorModel(code:0 ,codeError:  ErrorEnum.otherError,errorMessage:  "is not a subtype of exception");
    }
  }
}
