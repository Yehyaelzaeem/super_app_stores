
import 'package:cogina_restaurants/domain/logger.dart';

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/products_categories_model.dart';
import '../../../data/model/response/products_model.dart';
import '../../repository/home_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetProductsUseCase implements BaseUseCase<HomeModel>{
  final HomeRepository repository;
  GetProductsUseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<HomeModel>( await repository.getProducts(), onConvert,tag: 'GetProductsUseCase');
  }

  @override
  ResponseModel<HomeModel> onConvert(BaseModel baseModel) {
    HomeModel? homeModel = HomeModel.fromJson(baseModel.item);

    try{
      log('yehya', baseModel.item.toString());
      HomeModel? homeModel = HomeModel.fromJson(baseModel.item);
      return ResponseModel(baseModel.status??true, baseModel.message,data: homeModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
