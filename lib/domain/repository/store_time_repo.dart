
import '../../data/model/base/api_response.dart';

mixin FavoriteRepository {

  Future<ApiResponse> getFavorite() ;
  Future<ApiResponse> addFavorite({required int itemId}) ;
  Future<ApiResponse> removeFavorite({required int itemId}) ;
}
