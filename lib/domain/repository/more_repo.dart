
import '../../data/model/base/api_response.dart';


mixin MoreRepository {

  Future<ApiResponse> getAboutUs() ;
  Future<ApiResponse> getPrivacy() ;
  Future<ApiResponse> getTerms() ;

}
