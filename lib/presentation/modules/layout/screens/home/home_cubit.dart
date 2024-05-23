import 'dart:io';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/domain/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/extra_model.dart';
import '../../../../../data/model/response/products_categories_model.dart';
import '../../../../../data/model/response/products_model.dart';
import '../../../../../domain/request_body/add_product_body.dart';
import '../../../../../domain/usecase/home/add_product_usecase.dart';
import '../../../../../domain/usecase/home/delete_product_usecase.dart';
import '../../../../../domain/usecase/home/get_products_categories_usecase.dart';
import '../../../../../domain/usecase/home/get_products_usecase.dart';
import '../../../../../domain/usecase/home/update_product_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsCategoriesUseCase _getProductsCategoriesUseCase;
  final AddProductUseCase _addProductUseCase;
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  HomeCubit({required GetProductsCategoriesUseCase getProductsCategoriesUseCase,
  required UpdateProductUseCase updateProductUseCase,
  required DeleteProductUseCase deleteProductUseCase,
  required AddProductUseCase addProductUseCase,
  required GetProductsUseCase getProductsUseCase
  }) :
        _deleteProductUseCase=deleteProductUseCase,
        _updateProductUseCase=updateProductUseCase,
        _addProductUseCase=addProductUseCase,
        _getProductsUseCase=getProductsUseCase,
        _getProductsCategoriesUseCase=getProductsCategoriesUseCase,super(HomeInitial());

 static HomeCubit get(BuildContext context)=>BlocProvider.of(context);




  TextEditingController productName =TextEditingController();
  TextEditingController  productPrice =TextEditingController();
  TextEditingController  productExtraName =TextEditingController();
  TextEditingController  productExtraNameAr =TextEditingController();
  TextEditingController  productExtraPrice =TextEditingController();
  TextEditingController  productDisCount =TextEditingController();
  TextEditingController  productDescription =TextEditingController();
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> extraFormKey = GlobalKey<FormState>();

  String? categoryValue;
  int? categoryId;
  ProductsCategoriesModel? productsCategoriesModel;
  HomeModel? homeModel;
  Future<ResponseModel> getProductsCategories() async {
    emit(GetProductCategoriesLoadingState()) ;
    ResponseModel responseModel = await _getProductsCategoriesUseCase.call();
    if (responseModel.isSuccess) {
      productsCategoriesModel=responseModel.data;
      emit(GetProductCategoriesSuccessState()) ;
    }else{
      emit(GetProductCategoriesErrorState()) ;
    }
    return responseModel;
  }

  List<ExtraModel> extralList=[];
  void addExtra(ExtraModel extraModel){
    emit(ExtraModelLoadingState());
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      extralList.add(extraModel);
      productExtraNameAr.text='';
      productExtraName.text='';
      productExtraPrice.text='';
      emit(AddExtraModelState());
    });
  }
  void removeExtra(ExtraModel extraModel){
    extralList.remove(extraModel);
    emit(RemoveExtraModelState());
  }

  Future<ResponseModel> getProducts() async {
    emit(GetProductLoadingState()) ;
    ResponseModel responseModel = await _getProductsUseCase.call();
    if (responseModel.isSuccess) {
      log('ssss', responseModel.data.toString());
      homeModel=responseModel.data;
      emit(GetProductSuccessState()) ;
    }else{
      emit(GetProductErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> addProduct() async {
    AddProductBody addProductBody=AddProductBody(
        name: productName.text, description: productDescription.text,
        price: productPrice.text, discount: productDisCount.text, image: productImageFile!,
        categoryId: categoryId.toString(), additionName: extralList.map((e) => e.nameEn.trim()).join(','),
        additionNameAr: extralList.map((e) => e.nameAr.trim()).join(','),
        additionPrice: extralList.map((e) => e.price.toString()).join(','),
    );
    emit(AddProductLoadingState()) ;
    ResponseModel responseModel = await _addProductUseCase.call(addProductBody: addProductBody);
    if (responseModel.isSuccess) {
      getProducts();
      extralList.clear();
      NavigationService.navigationKey.currentContext!.pop();
      emit(AddProductSuccessState()) ;
    }else{
      emit(AddProductErrorState()) ;
    }
    return responseModel;
  }
  Future<ResponseModel> updateProduct({required int id,required BuildContext context}) async {
    emit(AddProductLoadingState()) ;
    AddProductBody addProductBody=AddProductBody(
        name: productName.text, description: productDescription.text,
        price: productPrice.text, discount: productDisCount.text, image: productImageFile,
        categoryId: categoryId.toString(), additionName: productExtraName.text,
        additionNameAr: productExtraNameAr.text,
        additionPrice: productExtraPrice.text,

    );
    ResponseModel responseModel = await _updateProductUseCase.call(addProductBody: addProductBody, id: id);
    if (responseModel.isSuccess) {
      getProducts();
      context.pop();
      emit(AddProductSuccessState()) ;
    }else{
      emit(AddProductErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> deleteProducts({required int id}) async {
    emit(DeleteProductLoadingState()) ;
    ResponseModel responseModel = await _deleteProductUseCase.call(id: id);
    if (responseModel.isSuccess) {
      getProducts();
      emit(DeleteProductSuccessState()) ;
    }else{
      emit(DeleteProductErrorState()) ;
    }
    return responseModel;
  }
  void removeProductTextFieldData(){
    productName.text='';
    productPrice.text='';
    categoryValue='';
    productExtraName.text='';
    productExtraNameAr.text='';
    productExtraPrice.text='';
    productDescription.text='';
    productImageFile=null;
    productDisCount.text='';
  }
  void pushProductTextFieldData(ProductData productData){
    productName.text=productData.name!;
    productPrice.text=productData.priceAfterDiscount!.toString();
    // if(productsCategoriesModel!=null){
    //   for(var a in productsCategoriesModel!.data!){
    //       if(a.id.toString()==productData.category!){
    //         categoryValue==productData.category!;
    //         categoryId==a.id!;
    //         break;
    //       }
    //   }
    // }
    if(productData.extra!=null&&productData.extra!.data!.isNotEmpty){
      productExtraName.text=productData.extra!.data![0].name.toString();
      productExtraNameAr.text=productData.extra!.data![0].name.toString();
      productExtraPrice.text=productData.extra!.data![0].price.toString();
    }
    productDescription.text=productData.description!;
    productDisCount.text=productData.discount!;
    emit(PushDataState());

  }
  File? productImageFile;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      productImageFile =File(image.path);
    }
    emit(PickImageState());
  }

}
