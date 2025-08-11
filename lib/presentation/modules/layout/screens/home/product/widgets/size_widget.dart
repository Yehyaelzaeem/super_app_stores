import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_text_field.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_title_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../../core/translations/locale_keys.dart';
import '../../../../../../../data/model/response/extra_model.dart';
import '../../../../../../component/custom_elevated_button.dart';
import '../../../../../../component/primary_button.dart';
import '../../home_cubit.dart';
import 'extra_add_item_widget.dart';
import 'extra_title_widget.dart';

class SizeProductWidget extends StatelessWidget {
  const SizeProductWidget({super.key}) ;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return
       StatefulBuilder(builder: (context, setState) {
         return BlocConsumer<HomeCubit, HomeState>(
           listener: (context, state) {},
           builder: (context, state) {
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Row(
                       children: [
                         Radio<String>(
                           value: '0',
                           groupValue: cubit.selectedPrice,
                           onChanged: (String? newValue) {
                             setState(() {
                               cubit.selectedPrice = newValue!;
                             });
                           },
                         ),
                         Text('${LocaleKeys.sizes.tr()}', style: TextStyles.font18Black700Weight.copyWith(color: Colors.grey.shade700,

                         fontSize: 15
                         )),
                       ],
                     ),
                     Row(
                       children: [
                         Radio<String>(
                           value: '1',
                           groupValue: cubit.selectedPrice,
                           onChanged: (String? newValue) {
                             setState(() {
                               cubit.selectedPrice = newValue!;
                             });
                           },
                         ),
                         Text('${LocaleKeys.constSize.tr()}', style: TextStyles.font18Black700Weight.copyWith(color: Colors.grey.shade700,

                             fontSize: 15

                         )),
                       ],
                     ),
                   ],
                 ),
                 if(cubit.selectedPrice=='0')
                   ... [ if( cubit.sizeProductList.isNotEmpty)
                     const ExtraTitleWidget(),
                     if( cubit.sizeProductList.isNotEmpty)
                       ...cubit.sizeProductList.map((e) =>  ExtraAddItemWidget(sizeProductModel:e,isSizeProduct: true,)),
                     verticalSpace(20),
                     Container(
                       width: MediaQuery.sizeOf(context).width,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           boxShadow:   [BoxShadow(color: primaryColor.withOpacity(0.05),blurRadius: 1)]
                       ),
                       child: Padding(
                         padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 10.w),
                         child: Form(
                           key:cubit.sizeFormKey,
                           child: Column(
                             children: [
                               if(cubit.showSize==true)
                                ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ProductTitleField(title: LocaleKeys.sizeEn.tr(),),
                                            ProductTextField(
                                              contentHorizontalPadding:20,
                                              textInputAction: TextInputAction.newline,
                                              textInputType: TextInputType.multiline,
                                              controller: cubit.productSizeNameEn,notValidation: true,),
                                          ],
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ProductTitleField(title:LocaleKeys.sizeAr.tr(),),
                                            ProductTextField(controller: cubit.productSizeNameAr,
                                              textInputAction: TextInputAction.newline,
                                              contentHorizontalPadding:20,
                                              textInputType: TextInputType.multiline,notValidation: true,),
                                          ],
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ProductTitleField(title: LocaleKeys.price.tr(),),
                                            ProductTextField(controller: cubit.productSizePrice,
                                              textInputAction: TextInputAction.newline,

                                              contentHorizontalPadding:20,
                                              textInputType: TextInputType.number,notValidation: true,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(5),
                                ],
                               PrimaryButtonWidget(
                                 color: primaryColor.withOpacity(0.2),
                                 boxShadowColor: primaryColor.withOpacity(0.2),
                                 fontColor: primaryColor,
                                 borderColor: Colors.white,
                                 isLoading: state is SizeProductLoadingState,
                                 radius: 25,
                                 width: 200.w,
                                 // height: 40.h,
                                 onTap: () {
                                   if(cubit.showSize==false){
                                     cubit.showSizeInput();
                                   }else{
                                           if(cubit.sizeFormKey.currentState!.validate()){
                                           SizeProductModel sizeProductModel=SizeProductModel(nameAr: cubit.productSizeNameAr.text,
                                           nameEn: cubit.productSizeNameEn.text, price: double.parse(cubit.productSizePrice.text));
                                           cubit.addSizeProduct(sizeProductModel);
                                           }
                                       cubit.hideSizeInput();

                                   }

                                 },
                                 text:LocaleKeys.add.tr(),),

                             ],
                           ),
                         ),
                       ),
                     ),]
                 else
                   ...[ProductTitleField(title: LocaleKeys.price.tr(),),
                     ProductTextField(
                       validationFunc: (value) {
                         return null;
                       },
                       controller: cubit.productPrice,
                       textInputType: TextInputType.number,

                     ),],
               ],
             );
           },
         );
       });
  }
}
