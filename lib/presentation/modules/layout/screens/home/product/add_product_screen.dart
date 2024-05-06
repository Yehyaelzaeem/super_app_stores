import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/prodcut_categories_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../component/custom_app_bar.dart';
import '../home_cubit.dart';
import 'widgets/product_text_field.dart';
import 'widgets/product_title_field.dart';


class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    cubit.removeProductTextFieldData();
    return Scaffold(
      backgroundColor:  backGroundGray,
      appBar:   CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.addMeal.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.productFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 ProductTitleField(title: LocaleKeys.mealName.tr(),),
                ProductTextField(controller: cubit.productName,),
                 ProductTitleField(title: LocaleKeys.price.tr(),),
                ProductTextField(controller: cubit.productPrice,
                textInputType: TextInputType.number,
                ),
                 ProductTitleField(title: LocaleKeys.category.tr(),),
                const ProductCategoriesWidget(),
                ProductTitleField(title: LocaleKeys.addition.tr(),),
                ProductTextField(controller: cubit.productExtraName,notValidation: true,),
                ProductTitleField(title:LocaleKeys.additionArabic.tr(),),
                ProductTextField(controller: cubit.productExtraNameAr
                  ,notValidation: true,),
                ProductTitleField(title: LocaleKeys.extraPrice.tr(),),
                ProductTextField(controller: cubit.productExtraPrice,
                  notValidation: true,
                  textInputType: TextInputType.number,),
                 ProductTitleField(title: '${LocaleKeys.discount.tr()}%',),
                ProductTextField(controller: cubit.productDisCount,
                  notValidation: true,
                  textInputType: TextInputType.number,),
                 ProductTitleField(title: LocaleKeys.description.tr(),),
                ProductTextField(controller: cubit.productDescription,
                textInputType: TextInputType.multiline,
                ),
                verticalSpace(15),
                 const ProductImageAndButtonWidget(type:'add',),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
