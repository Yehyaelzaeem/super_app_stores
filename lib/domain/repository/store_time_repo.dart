
import '../../data/model/base/api_response.dart';
import '../../data/model/response/delivery_time.dart';
import '../../data/model/response/time_params.dart';

mixin StoreTimeRepository {

  Future<ApiResponse> addStoreTime({required TimeParams params}) ;


  /// add delivery time
  Future<ApiResponse> addDeliveryTime({required DeliveryTimeParams params}) ;
}
