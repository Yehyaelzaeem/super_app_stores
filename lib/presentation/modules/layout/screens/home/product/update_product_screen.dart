import 'package:cogina_restaurants/core/utils/toast_states/enums.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/extra_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/prodcut_categories_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_image_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/size_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../data/model/response/products_model.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../home_cubit.dart';
import 'widgets/product_text_field.dart';
import 'widgets/product_title_field.dart';


class UpdateProductScreen extends StatelessWidget {
  final ProductData product;
  const UpdateProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    cubit.removeProductTextFieldData();
    cubit.pushProductTextFieldData(product);
    print(product.extra!.data!.map((e) => e.toJson()).toList());
    return Scaffold(
      backgroundColor:  backGroundGray,
      appBar:   CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.mealUpdate.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.productFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 ProductTitleField(title: LocaleKeys.mealName.tr()),
                ProductTextField(controller: cubit.productName,),
                ProductTitleField(title: LocaleKeys.mealNameAr.tr(),),
                ProductTextField(controller: cubit.productNameAr,),

                ProductTitleField(title: LocaleKeys.category.tr(),),
                const ProductCategoriesWidget(),
                // ProductTitleField(title: LocaleKeys.addition.tr(),),
                // ProductTextField(controller: cubit.productExtraName,notValidation: true,),
                // ProductTitleField(title:LocaleKeys.additionArabic.tr(),),
                // ProductTextField(controller: cubit.productExtraNameAr
                //   ,notValidation: true,),
                // ProductTitleField(title: LocaleKeys.extraPrice.tr(),),
                // ProductTextField(controller: cubit.productExtraPrice,
                //   notValidation: true,
                //   textInputType: TextInputType.number,),
                ProductTitleField(title: LocaleKeys.discount.tr(),),
                ProductTextField(controller: cubit.productDisCount,
                  notValidation: true,
                  textInputType: TextInputType.number,),
                ProductTitleField(title: LocaleKeys.description.tr(),),
                ProductTextField(controller: cubit.productDescription,),
                ProductTitleField(title: LocaleKeys.descriptionAr.tr(),),
                ProductTextField(controller: cubit.productDescriptionAR,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
                verticalSpace(15),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: backGroundGray,
                          boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 7)]
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizeProductWidget(),
                      )),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 20.h),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: backGroundGray,
                          boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 7)]
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ExtraWidget(),
                      )),
                ),
                verticalSpace(10),
                 ProductImageAndButtonWidget(type: 'update',id: product.id!,image: product.image!,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
