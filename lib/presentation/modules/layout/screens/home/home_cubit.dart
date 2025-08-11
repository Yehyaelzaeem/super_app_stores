import 'dart:io';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/routing/navigation_services.dart';
import '../../../../../core/utils/contact_helper.dart';
import '../../../../../data/model/base/response_model.dart';
import '../../../../../data/model/response/extra_model.dart';
import '../../../../../data/model/response/products_categories_model.dart';
import '../../../../../data/model/response/products_model.dart';
import '../../../../../domain/request_body/add_product_body.dart';
import '../../../../../domain/usecase/home/add_offer_product_usecase.dart';
import '../../../../../domain/usecase/home/add_product_usecase.dart';
import '../../../../../domain/usecase/home/change_product_state_usecase.dart';
import '../../../../../domain/usecase/home/delete_product_usecase.dart';
import '../../../../../domain/usecase/home/get_products_categories_usecase.dart';
import '../../../../../domain/usecase/home/get_products_usecase.dart';
import '../../../../../domain/usecase/home/update_offer_product_usecase.dart';
import '../../../../../domain/usecase/home/update_product_usecase.dart';
import '../../../../component/choose_from_list_widget.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsCategoriesUseCase _getProductsCategoriesUseCase;
  final AddProductUseCase _addProductUseCase;
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final AddOfferProductUseCase _addOfferProductUseCase;
  final UpdateOfferProductUseCase _updateOfferProductUseCase;

  final UpdateProductUseCase _updateProductUseCase;
  final ChangeProductStateUseCase _changeProductStateUseCase;
  HomeCubit({required GetProductsCategoriesUseCase getProductsCategoriesUseCase,
    required UpdateProductUseCase updateProductUseCase,
    required UpdateOfferProductUseCase updateOfferProductUseCase,
    required AddOfferProductUseCase addOfferProductUseCase,
    required ChangeProductStateUseCase changeProductStateUseCase,
    required DeleteProductUseCase deleteProductUseCase,

    required AddProductUseCase addProductUseCase,
    required GetProductsUseCase getProductsUseCase
  }) :
        _deleteProductUseCase=deleteProductUseCase,
        _updateProductUseCase=updateProductUseCase,
        _changeProductStateUseCase=changeProductStateUseCase,
        _addOfferProductUseCase=addOfferProductUseCase,
        _updateOfferProductUseCase=updateOfferProductUseCase,
        _addProductUseCase=addProductUseCase,
        _getProductsUseCase=getProductsUseCase,
        _getProductsCategoriesUseCase=getProductsCategoriesUseCase,super(HomeInitial());

  static HomeCubit get(BuildContext context)=>BlocProvider.of(context);



  bool checkValue =false;

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
  TextEditingController  productSizeNameAr =TextEditingController();
  TextEditingController  productSizeNameEn =TextEditingController();
  TextEditingController  productSizePrice =TextEditingController();
  String? categoryValue;
  GlobalKey<FormState> sizeFormKey = GlobalKey<FormState>();

  int? categoryId;
  ProductsCategoriesModel? productsCategoriesModel;
  HomeModel? homeModel;
  HomeModel? filterHomeModel;
  String? selectedPrice = '0';

  Future<void> filterProductHome(ChooseItemListModel selectedItem) async{
    emit(GetProductLoadingState());
    if(selectedItem.id ==-100){
      filterHomeModel =homeModel;
      emit(GetProductSuccessState());
      return null;
    }
    if (homeModel != null && homeModel!.productsModel != null) {
      filterHomeModel = HomeModel(
        productsModel: Products(
          data: List.from(homeModel!.productsModel!.data!),
        ),
      );
      filterHomeModel?.productsModel?.data = homeModel!.productsModel!.data!
          .where((product) => product.category?.id == selectedItem.id)
          .toList();
      emit(GetProductSuccessState());
    } else {
    }
  }

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

  /// Size Product List
  List<SizeProductModel> sizeProductList=[];
  void addSizeProduct(SizeProductModel sizeProductModel){
    emit(SizeProductLoadingState());
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      sizeProductList.add(sizeProductModel);
      productSizeNameAr.text='';
      productSizeNameEn.text='';
      productSizePrice.text='';
      emit(SizeProductsSuccessState());
    });
  }

  void removeSizeProduct(SizeProductModel sizeProductModel){
    sizeProductList.remove(sizeProductModel);
    emit(RemoveSizeProductState());
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

  ///Show Input Extra
   bool showExtra = true;
  void showExtraInput(){
    showExtra = true;
    emit(ShowExtraInputState());
  }
  void hideExtraInput(){
    showExtra = false;
    // emit(HideExtraInputState());
  }
  bool showSize = true;
  void showSizeInput(){
    showSize = true;
    emit(ShowExtraInputState());
  }
  void hideSizeInput(){
    showSize = false;
    // emit(HideExtraInputState());
  }
  void removeExtra(ExtraModel extraModel){
    extralList.remove(extraModel);
    emit(RemoveExtraModelState());
  }
  Future<ResponseModel> changeProductsState({required int id,}) async {
    // emit(ChangeProductLoadingState()) ;
    ResponseModel responseModel = await _changeProductStateUseCase.call(id: id);
    if (responseModel.isSuccess) {
      getProducts();
      // emit(ChangeProductSuccessState()) ;
    }else{
      // emit(ChangeProductErrorState()) ;
    }
    return responseModel;
  }


  Future<ResponseModel> getProducts({bool reload=false}) async {
    if(reload==true){
      filterHomeModel=null;
      homeModel=null;
      emit(GetProductLoadingState()) ;
    }
    emit(GetProductLoadingState()) ;

    ResponseModel responseModel = await _getProductsUseCase.call();
    if (responseModel.isSuccess) {
      filterHomeModel=responseModel.data;

      homeModel=responseModel.data;
      emit(GetProductSuccessState()) ;
    }else{
      emit(GetProductErrorState()) ;
    }
    return responseModel;
  }

  Future<ResponseModel?> addProduct() async {
    try{
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
        sizeNameEn:selectedPrice=='0'? sizeProductList.map((e) => e.nameEn.trim()).join(','):"",
        sizeNameAr:selectedPrice=='0'? sizeProductList.map((e) => e.nameAr.trim()).join(','):"",
        sizePrice: selectedPrice=='0'? sizeProductList.map((e) => e.price.toString()).join(','):"",
        bestDishes:checkValue==true?'1':'0',
      );
      emit(AddProductLoadingState()) ;
      ResponseModel responseModel = await _addProductUseCase.call(addProductBody: addProductBody);
      if (responseModel.isSuccess) {
        getProducts();
        extralList.clear();
        sizeProductList.clear();
        NavigationService.navigationKey.currentContext!.pop();
        emit(AddProductSuccessState()) ;
      }else{
        emit(AddProductErrorState()) ;
      }
      return responseModel;
    }catch(e){
      emit(AddProductErrorState()) ;
    }
  }
  Future<ResponseModel?> updateProduct({required int id,required BuildContext context}) async {
    try{
      emit(AddProductLoadingState()) ;
      AddProductBody addProductBody=AddProductBody(
        name: productName.text,
        nameAr: productNameAr.text,
        descriptionAr: productDescriptionAR.text,
        description: productDescription.text,
        price: productPrice.text, discount:
      productDisCount.text,
         image: productImageFile??null,
        categoryId: categoryId.toString(),
        additionName: extralList.map((e) =>e.nameEn.isNotEmpty? e.nameEn.trim():e.nameAr.trim()).join(','),
        additionNameAr: extralList.map((e) =>e.nameAr.isNotEmpty? e.nameAr.trim():e.nameEn.trim()).join(','),
        additionPrice:  extralList.map((e) => e.price.toString()).join(','),
        bestDishes:checkValue==true?'1':'0',
        sizeNameEn:selectedPrice=='0'? sizeProductList.map((e) => e.nameEn.trim()).join(','):"",
        sizeNameAr:selectedPrice=='0'? sizeProductList.map((e) => e.nameAr.trim()).join(','):"",
        sizePrice: selectedPrice=='0'? sizeProductList.map((e) => e.price.toString()).join(','):"",

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
    }catch(e){
      emit(AddProductErrorState()) ;

    }
  }
  Future<ResponseModel?> addOfferProduct() async {
    try{
      AddProductBody addProductBody=AddProductBody(
        name: productName.text,
        nameAr: productNameAr.text,
        descriptionAr: productDescriptionAR.text,
        description: productDescription.text,
        price: selectedPrice=='1'? productPrice.text:'',
        discount: productDisCount.text, image: productImageFile!,
        categoryId: categoryId.toString(),
        additionName: extralList.map((e) => e.nameEn.trim()).join(','),
        additionNameAr: extralList.map((e) => e.nameAr.trim()).join(','),
        additionPrice: extralList.map((e) => e.price.toString()).join(','),
        sizeNameEn:selectedPrice=='0'? sizeProductList.map((e) => e.nameEn.trim()).join(','):"",
        sizeNameAr:selectedPrice=='0'? sizeProductList.map((e) => e.nameAr.trim()).join(','):"",
        sizePrice: selectedPrice=='0'? sizeProductList.map((e) => e.price.toString()).join(','):"",
        bestDishes:checkValue==true?'1':'0',

      );
      emit(AddProductLoadingState()) ;
      ResponseModel responseModel = await _addOfferProductUseCase.call(addProductBody: addProductBody);
      if (responseModel.isSuccess) {
        getProducts();
        extralList.clear();
        NavigationService.navigationKey.currentContext!.pop();
        emit(AddProductSuccessState()) ;
      }
      else{
        emit(AddProductErrorState()) ;
      }
      return responseModel;

    }catch(e){
      emit(AddProductErrorState()) ;
    }
  }

  Future<ResponseModel?> updateOfferProduct({required int id,required BuildContext context}) async {
    try{
      emit(AddProductLoadingState()) ;
      AddProductBody addProductBody=AddProductBody(
        name: productName.text,
        nameAr: productNameAr.text,
        descriptionAr: productDescriptionAR.text,
        description: productDescription.text,
        price: selectedPrice=='1'?productPrice.text:'',
        discount: productDisCount.text,
        categoryId: categoryId.toString(),
        additionName: extralList.map((e) =>e.nameEn.isNotEmpty? e.nameEn.trim():e.nameAr.trim()).join(','),
        additionNameAr: extralList.map((e) =>e.nameAr.isNotEmpty? e.nameAr.trim():e.nameEn.trim()).join(','),
        additionPrice:  extralList.map((e) => e.price.toString()).join(','),
        sizeNameEn:selectedPrice=='0'? sizeProductList.map((e) => e.nameEn.trim()).join(','):"",
        sizeNameAr:selectedPrice=='0'? sizeProductList.map((e) => e.nameAr.trim()).join(','):"",
        sizePrice: selectedPrice=='0'? sizeProductList.map((e) => e.price.toString()).join(','):"",
        bestDishes:checkValue==true?'1':'0',

      );
      ResponseModel responseModel = await _updateOfferProductUseCase.call(addProductBody: addProductBody, id: id);
      if (responseModel.isSuccess) {
        getProducts();
        context.pop();
        emit(AddProductSuccessState()) ;
      }else{
        emit(AddProductErrorState()) ;
      }
      return responseModel;
    }catch(e){
      emit(AddProductErrorState()) ;

    }
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
    productNameAr.text='';
    productPrice.text='';
    categoryValue='';
    productExtraName.text='';
    productExtraNameAr.text='';
    productExtraPrice.text='';
    productDescription.text='';
    productDescriptionAR.text='';
    productImageFile=null;
    extralList.clear();
    sizeProductList.clear();
    productDisCount.text='';
  }

  void pushProductTextFieldData(ProductData productData){
    print('dddee ${productData.toJson()}');
    checkValue=productData.bestDishes==1?true:false;
    productName.text=productData.nameEn??'';
    productNameAr.text=productData.nameAr??'';
    productDescriptionAR.text= ContactHelper.removeHtmlTags(productData.descriptionAr??'');
    productDescription.text= ContactHelper.removeHtmlTags(productData.descriptionEn??'');
    categoryId=productData.category?.id??0;
    categoryValue=productData.category?.name??'';
    productPrice.text=productData.price!.toString();


    // if(productData.extra!=null&&productData.extra!.data!.isNotEmpty){
    //   productExtraName.text=productData.extra!.data![0].name.toString();
    //   productExtraNameAr.text=productData.extra!.data![0].name.toString();
    //   productExtraPrice.text=productData.extra!.data![0].price.toString();
    // }
    if(productData.productSize!=null&&productData.productSize!.data!=null&&productData.productSize!.data!.isNotEmpty){
      selectedPrice='0';
      for(var a in productData.productSize!.data! ){
        sizeProductList.add(SizeProductModel(nameAr: a.nameAr??'', nameEn: a.nameEn??'', price:a.price!=null? double.parse(a.price.toString()):0.0));
      }
    }else{
      selectedPrice='1';
    }
    productDisCount.text=productData.discount??'';
    for(var a in productData.extra!.data! ){
      extralList.add(ExtraModel(nameAr: a.nameAr??'', nameEn: a.nameEn??'', price:a.price!=null? double.parse(a.price.toString()):0.0));
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
