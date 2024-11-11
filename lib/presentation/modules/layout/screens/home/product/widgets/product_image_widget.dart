import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/size_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../../core/utils/toast_states/enums.dart';
import '../../../../../../component/custom_elevated_button.dart';
import '../../../../../../component/primary_button.dart';
import 'extra_widget.dart';

class ProductImageAndButtonWidget extends StatelessWidget {
  const ProductImageAndButtonWidget({super.key, required this.type,  this.id, this.image, this.isOffer});
  final String type;
  final int? id;
  final bool? isOffer;
  final String? image;
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [

            Center(
              child: InkWell(
                onTap: (){
                  cubit.pickImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white
                  ),
                  child:
                  cubit.productImageFile!=null?
                  SizedBox(
                    height:100.w,
                    width:150.w,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(cubit.productImageFile!,
                          fit: BoxFit.cover,
                        ),),
                    ),
                  ):
                  SizedBox(
                    height:100.w,
                    width:150.w,
                    child:  Center(
                      child:
                      type=='update' && image!=null?
                      CustomImage(image: image??'',radius: 25,
                        height: 100.h,
                        width: 150.w,
                      ):
                      Icon(Icons.add_photo_alternate_outlined,size: 100,color: Colors.grey,),
                    ),
                  ),
                ),
              ),
            ),

            verticalSpace(20),
           FittedBox(
             fit: BoxFit.scaleDown,
             child:  Padding(
               padding: EdgeInsets.symmetric(horizontal: 16.w),
               child: Row(
                 children: [

                   Text('${LocaleKeys.bestDishesMess.tr()}', style: TextStyles.font18Black700Weight.copyWith(
                       fontSize:10.sp ,
                       color: Colors.grey.shade700)),
                   StatefulBuilder(builder: (context,setState){
                     return  Checkbox(
                         value: cubit.checkValue,
                         onChanged: (bool? val){
                           setState((){
                             cubit.checkValue=val!;
                           });
                         });
                   })
                 ],
               ),
             ),
           ),

            verticalSpace(5),
            PrimaryButtonWidget(
              isLoading: state is AddProductLoadingState,
              radius: 15,
              height: 50.h,
                onTap: () {
                if(isOffer==true){
                  if(type=='update'){
                    print(cubit.productPrice.text);
                    if(cubit.productFormKey.currentState!.validate()){
                      if(cubit.categoryId==null){
                        showToast(text: LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                      }
                      else if((cubit.productPrice.text.isEmpty || cubit.productPrice.text == '0')  && cubit.sizeProductList.isEmpty){
                        showToast(text: LocaleKeys.choosePrice.tr(), state: ToastStates.error, context: context);
                      }

                      else{
                        cubit.updateOfferProduct(id: id??0, context: context);
                      }
                    }
                  }
                  else{
                    if(cubit.productFormKey.currentState!.validate()){
                      if(cubit.categoryId==null){
                        showToast(text:  LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                      }
                      else if(cubit.productImageFile==null){
                        showToast(text: LocaleKeys.chooseImage.tr(), state: ToastStates.error, context: context);
                      }
                      else if(cubit.productPrice.text.isEmpty && cubit.sizeProductList.isEmpty){
                        showToast(text: LocaleKeys.choosePrice.tr(), state: ToastStates.error, context: context);
                      }
                      else{
                        cubit.addOfferProduct();
                      }
                    }
                  }
                }else{
                  if(type=='update'){
                    print(cubit.productPrice.text);
                    if(cubit.productFormKey.currentState!.validate()){
                      if(cubit.categoryId==null){
                        showToast(text: LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                      }
                      else if((cubit.productPrice.text.isEmpty || cubit.productPrice.text == '0')  && cubit.sizeProductList.isEmpty){
                        showToast(text: LocaleKeys.choosePrice.tr(), state: ToastStates.error, context: context);
                      }

                      else{
                        cubit.updateProduct(id: id??0, context: context);
                      }
                    }
                  }else{
                    if(cubit.productFormKey.currentState!.validate()){
                      if(cubit.categoryId==null){
                        showToast(text:  LocaleKeys.chooseCategory.tr(), state: ToastStates.error, context: context);
                      }
                      else if(cubit.productImageFile==null){
                        showToast(text: LocaleKeys.chooseImage.tr(), state: ToastStates.error, context: context);
                      }
                      else if(cubit.productPrice.text.isEmpty && cubit.sizeProductList.isEmpty){
                        showToast(text: LocaleKeys.choosePrice.tr(), state: ToastStates.error, context: context);
                      }
                      else{
                        cubit.addProduct();
                      }
                    }
                  }
                }

                },
              text:type=='update'?LocaleKeys.update.tr():LocaleKeys.add.tr(),),

            verticalSpace(20),
          ],
        );
      },
    );
  }
}
