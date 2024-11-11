import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/restaurant_types_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/login_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class RestaurantCategoriesUseCase implements BaseUseCase<RestaurantTypesModel>{


  final AuthRepository repository;

  RestaurantCategoriesUseCase({required this.repository});

  Future<ResponseModel> call(int id) async {
    return BaseUseCaseCall.onGetData<RestaurantTypesModel>( await repository.getRestaurantCategories(id), onConvert,showError: true,tag: 'RestaurantCategoriesUseCase');
  }

  @override
  ResponseModel<RestaurantTypesModel> onConvert(BaseModel baseModel) {
    try{
      RestaurantTypesModel? typesModel = RestaurantTypesModel.fromJson(baseModel.item);
      return ResponseModel(baseModel.status??true, baseModel.message,data: typesModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.item);
    }
  }
}
