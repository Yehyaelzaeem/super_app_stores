
import '../../data/model/base/api_response.dart';
import '../request_body/add_product_body.dart';
import '../request_body/check_otp_body.dart';
import '../request_body/login_body.dart';
import '../request_body/otp_body.dart';
import '../request_body/register_body.dart';


mixin HomeRepository {
  Future<ApiResponse> getProductsCategories() ;
  Future<ApiResponse> getProducts() ;
  Future<ApiResponse> addProduct({required AddProductBody addProductBody}) ;
  Future<ApiResponse> deleteProduct({required int id}) ;
  Future<ApiResponse> updateProduct({required AddProductBody addProductBody,required int id}) ;

}
