
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/products_categories_model.dart';
import '../../repository/home_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetProductsCategoriesUseCase implements BaseUseCase<ProductsCategoriesModel>{
  final HomeRepository repository;
  GetProductsCategoriesUseCase({required this.repository});
  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<ProductsCategoriesModel>( await repository.getProductsCategories(), onConvert,tag: 'GetProductsCategoriesUseCase');
  }

  @override
  ResponseModel<ProductsCategoriesModel> onConvert(BaseModel baseModel) {
    try{
      ProductsCategoriesModel? productsCategoriesModel = ProductsCategoriesModel.fromJson(baseModel.item);
      return ResponseModel(baseModel.status??true, baseModel.message,data: productsCategoriesModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
