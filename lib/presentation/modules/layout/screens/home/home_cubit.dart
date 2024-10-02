import 'dart:io';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/extra_model.dart';
import '../../../../../data/model/response/products_categories_model.dart';
import '../../../../../data/model/response/products_model.dart';
import '../../../../../domain/request_body/add_product_body.dart';
import '../../../../../domain/usecase/home/add_product_usecase.dart';
import '../../../../../domain/usecase/home/change_product_state_usecase.dart';
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
  final ChangeProductStateUseCase _changeProductStateUseCase;
  HomeCubit({required GetProductsCategoriesUseCase getProductsCategoriesUseCase,
  required UpdateProductUseCase updateProductUseCase,
  required ChangeProductStateUseCase changeProductStateUseCase,
  required DeleteProductUseCase deleteProductUseCase,
  required AddProductUseCase addProductUseCase,
  required GetProductsUseCase getProductsUseCase
  }) :
        _deleteProductUseCase=deleteProductUseCase,
        _updateProductUseCase=updateProductUseCase,
        _changeProductStateUseCase=changeProductStateUseCase,
        _addProductUseCase=addProductUseCase,
        _getProductsUseCase=getProductsUseCase,
        _getProductsCategoriesUseCase=getProductsCategoriesUseCase,super(HomeInitial());

 static HomeCubit get(BuildContext context)=>BlocProvider.of(context);




  TextEditingController productName =TextEditingController();
  TextEditingController productNameAr =TextEditingController();
  TextEditingController  productPrice =TextEditingController();
  TextEditingController  productExtraName =TextEditingController();
  TextEditingController  productExtraNameAr =TextEditingController();
  TextEditingController  productExtraPrice =TextEditingController();
  TextEditingController  productDisCount =TextEditingController();
  TextEditingController  productDescription =TextEditingController();
  TextEditingController  productDescriptionAR=TextEditingController();
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
  Future<ResponseModel> changeProductsState({required int id,}) async {
    emit(ChangeProductLoadingState()) ;
    ResponseModel responseModel = await _changeProductStateUseCase.call(id: id);
    if (responseModel.isSuccess) {
      getProducts();
      emit(ChangeProductSuccessState()) ;
    }else{
      emit(ChangeProductErrorState()) ;
    }
    return responseModel;
  }


  Future<ResponseModel> getProducts() async {
    emit(GetProductLoadingState()) ;
    ResponseModel responseModel = await _getProductsUseCase.call();
    if (responseModel.isSuccess) {
      homeModel=responseModel.data;
      emit(GetProductSuccessState()) ;
    }else{
      emit(GetProductErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel> addProduct() async {
    AddProductBody addProductBody=AddProductBody(
        name: productName.text,
            nameAr: productNameAr.text,
            descriptionAr: productDescriptionAR.text,
            description: productDescription.text,
        price: productPrice.text, discount: productDisCount.text, image: productImageFile!,
        categoryId: categoryId.toString(),
        additionName: extralList.map((e) => e.nameEn.trim()).join(','),
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
        name: productName.text,
       nameAr: productNameAr.text,
       descriptionAr: productDescriptionAR.text,
      description: productDescription.text,
        price: productPrice.text, discount: productDisCount.text,
       // image: productImageFile??null,
        categoryId: categoryId.toString(),
        additionName: extralList.map((e) =>e.nameEn.isNotEmpty? e.nameEn.trim():e.nameAr.trim()).join(','),
        additionNameAr: extralList.map((e) =>e.nameAr.isNotEmpty? e.nameAr.trim():e.nameEn.trim()).join(','),
        additionPrice:  extralList.map((e) => e.price.toString()).join(','),
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
    extralList.clear();
    productDisCount.text='';
  }
  void pushProductTextFieldData(ProductData productData){
    productName.text=productData.name??'';
    productNameAr.text=productData.nameAr??'';
    productDescriptionAR.text=productData.descriptionAr??'';
    productDescription.text=productData.description??'';
    categoryId=productData.category?.id??0;
    categoryValue=productData.category?.name??'';
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

    // if(productData.extra!=null&&productData.extra!.data!.isNotEmpty){
    //   productExtraName.text=productData.extra!.data![0].name.toString();
    //   productExtraNameAr.text=productData.extra!.data![0].name.toString();
    //   productExtraPrice.text=productData.extra!.data![0].price.toString();
    // }
    productDisCount.text=productData.discount??'';
    for(var a in productData.extra!.data! ){
      if(appContext.locale.languageCode.toString()=='en'){
        extralList.add(ExtraModel(nameAr: '', nameEn: a.name??'', price:a.price!=null? double.parse(a.price.toString()):0.0));
      }else{
        extralList.add(ExtraModel(nameAr: a.name??'', nameEn: '', price:a.price!=null? double.parse(a.price.toString()):0.0));
      }
    }
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
