
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/home_repo.dart';
import '../../request_body/add_product_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class AddOfferProductUseCase implements BaseUseCase<dynamic>{
  final HomeRepository repository;
  AddOfferProductUseCase({required this.repository});
  Future<ResponseModel> call({required AddProductBody addProductBody}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.addOfferProductUseCase(addProductBody: addProductBody), onConvert,tag: 'AddOfferProductUseCase');
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
