import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_text_field.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_title_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/translations/locale_keys.dart';
import '../../../../../../../data/model/response/extra_model.dart';
import '../../../../../../component/custom_elevated_button.dart';
import '../../../../../../component/primary_button.dart';
import '../../home_cubit.dart';
import 'extra_add_item_widget.dart';
import 'extra_title_widget.dart';

class ExtraWidget extends StatelessWidget {
  const ExtraWidget({super.key}) ;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return  BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            if( cubit.extralList.isNotEmpty)
              const ExtraTitleWidget(),
            if( cubit.extralList.isNotEmpty)
              ...cubit.extralList.map((e) =>  ExtraAddItemWidget(extraModel: e,)),
            verticalSpace(20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:   [BoxShadow(color: primaryColor.withOpacity(0.05),blurRadius: 1)]
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 10.w),
                child: Form(
                  key:cubit.extraFormKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ProductTitleField(title: LocaleKeys.addition.tr(),),
                                ProductTextField(
                                  contentHorizontalPadding:20,
                                  textInputAction: TextInputAction.newline,

                                  textInputType: TextInputType.multiline,
                                  controller: cubit.productExtraName,notValidation: true,),
                              ],
                            ),
                          ),
                          horizontalSpace(5),
                          Expanded(
                            child: Column(
                              children: [
                                ProductTitleField(title:LocaleKeys.additionArabic.tr(),),
                                ProductTextField(controller: cubit.productExtraNameAr,
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
                                ProductTitleField(title: LocaleKeys.extraPrice.tr(),),
                                ProductTextField(controller: cubit.productExtraPrice,
                                  textInputAction: TextInputAction.newline,

                                  contentHorizontalPadding:20,
                                  textInputType: TextInputType.number,notValidation: true,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(5),
                      PrimaryButtonWidget(
                        color: primaryColor.withOpacity(0.2),
                        boxShadowColor: primaryColor.withOpacity(0.2),
                        fontColor: primaryColor,
                        borderColor: Colors.white,
                        isLoading: state is ExtraModelLoadingState,
                        radius: 25,
                        width: 200.w,
                        height: 40.h,
                        onTap: () {
                          if(cubit.extraFormKey.currentState!.validate()){
                            ExtraModel extraModel =
                            ExtraModel(nameAr: cubit.productExtraNameAr.text,
                                nameEn: cubit.productExtraName.text, price: double.parse(cubit.productExtraPrice.text));
                            cubit.addExtra(extraModel);
                          }
                        },
                        text:LocaleKeys.add.tr(),),
                      // Center(
                      //   child: CustomElevatedButton(
                      //     isLoading:state is ExtraModelLoadingState,
                      //     backgroundColor: primaryColor.withOpacity(0.1),
                      //     onTap: (){
                      //
                      //
                      //     },
                      //     buttonText:LocaleKeys.add.tr(),
                      //     width: MediaQuery.of(context).size.width*0.3,
                      //     height: 40,
                      //     fontSize: 17,
                      //     fontColor: primaryColor,
                      //     borderRadius: 40,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
