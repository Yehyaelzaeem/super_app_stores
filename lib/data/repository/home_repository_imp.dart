import 'dart:async';
import 'package:cogina_restaurants/domain/request_body/add_product_body.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/home_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class HomeRepositoryImp implements HomeRepository{
  final DioClient _dioClient;
  const HomeRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;



  @override
  Future<ApiResponse> getProductsCategories()async {
    try {
      Response response = await _dioClient.post(
        AppURL.kGetProductsCategoriesURL,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> addProduct({required AddProductBody addProductBody})async {
    try {
      var data = FormData.fromMap({
        'image': [
          await MultipartFile.fromFile(addProductBody!.image!.path!, filename: 'upload')
        ],
        'name': addProductBody.name,
        'name_ar': addProductBody.nameAr,
        'description_ar': addProductBody.descriptionAr,
        'description': addProductBody.description,
        'price': addProductBody.price,
        'discount': addProductBody.discount,
        'category_id': addProductBody.categoryId,
        // 'main_category_id': '1',
        'addition_name': addProductBody.additionName,
        'addition_name_ar': addProductBody.additionNameAr,
        'addition_price': addProductBody.additionPrice,
        '': ''
      });
      Response response = await _dioClient.post(
        AppURL.kAddProductURL,
        data2:data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getProducts() async{
    try {
      Response response = await _dioClient.get(
        AppURL.kGetProductsURL,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> deleteProduct({required int id})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kDeleteProductURL(id: id),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updateProduct({required AddProductBody addProductBody,required int id})async {
    try {
      var data = FormData.fromMap({
        'name': addProductBody.name,
        'description': addProductBody.description,
        'price': addProductBody.price,
        'discount': addProductBody.discount,
        'category_id': addProductBody.categoryId,
        // 'main_category_id': '1',
        'addition_name': addProductBody.additionName,
        'addition_name_ar': addProductBody.additionNameAr,
        'addition_price': addProductBody.additionPrice,
        '': ''
      });

      if(addProductBody.image!=null){
        data.files.add(MapEntry('image', await MultipartFile.fromFile(addProductBody.image!.path, filename: 'upload')));
      }
      Response response = await _dioClient.post(
        AppURL.kUpdateProductURL(id: id),
        data2: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> changeProductState({required int id})async {
    try {
      Response response = await _dioClient.post(
        AppURL.kChangeProductStateURL(id: id),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
