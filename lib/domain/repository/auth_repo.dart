
import '../../data/model/base/api_response.dart';
import '../request_body/check_otp_body.dart';
import '../request_body/complete_profile_body.dart';
import '../request_body/login_body.dart';
import '../request_body/otp_body.dart';
import '../request_body/register_body.dart';


mixin AuthRepository {
  Future<ApiResponse> login({required LoginBody loginBody}) ;

  Future<ApiResponse> otpCode({required OTPBody otpBody});
   Future<ApiResponse> updateFCMToken({required String fcmToken});

  Future<ApiResponse> register({required RegisterBody registerBody});
  Future<ApiResponse> completeProfile({required CompleteProfileBody completeProfileBody});

  // Future<ApiResponse> deleteAccount();

}
