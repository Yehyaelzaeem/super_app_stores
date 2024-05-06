
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/products_categories_model.dart';
import '../../repository/home_repo.dart';
import '../../request_body/add_product_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class AddProductUseCase implements BaseUseCase<dynamic>{
  final HomeRepository repository;
  AddProductUseCase({required this.repository});
  Future<ResponseModel> call({required AddProductBody addProductBody}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.addProduct(addProductBody: addProductBody), onConvert,tag: 'AddProductUseCase');
  }

  @override
  ResponseModel<dynamic> onConvert(BaseModel baseModel) {
    try{
      if(baseModel.code =='200' ||baseModel.code =='201'){
        return ResponseModel(baseModel.status??true, baseModel.message,data: baseModel.item);
      }else{
        return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
      }
      }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
