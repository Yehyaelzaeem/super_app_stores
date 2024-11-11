
import 'dart:io';

import '../../data/model/base/api_response.dart';
import '../../data/model/response/send_prescription_params.dart';
import '../request_body/account_files_body.dart';
import '../request_body/bank_account_body.dart';
import '../request_body/profile_body.dart';


mixin AccountRepository {
  Future<ApiResponse> getAboutUs() ;
  Future<ApiResponse> getPrivacy() ;
  Future<ApiResponse> getPrescriptions() ;
  Future<ApiResponse> sendPricePrescription({required SendPrescriptionParams sendPrescriptionParams}) ;
  Future<ApiResponse> getTerms() ;

  Future<ApiResponse> bankAccount({required BankAccountBody bankAccountBody}) ;
  Future<ApiResponse> addAccountFiles({required AccountFilesBody accountFilesBody}) ;
}
