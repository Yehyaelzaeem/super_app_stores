import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/extra_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/prodcut_categories_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_image_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/size_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';
import '../home_cubit.dart';
import 'widgets/product_text_field.dart';
import 'widgets/product_title_field.dart';

class AddProductScreen extends StatefulWidget {
  final bool? isOffer;

  const AddProductScreen({super.key, required this.isOffer});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.getProductsCategories();
    cubit.removeProductTextFieldData();
    cubit.productDisCount = TextEditingController(text: '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.addMeal.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.productFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitleField(
                  title: LocaleKeys.mealName.tr(),
                ),
                ProductTextField(
                  controller: cubit.productName,
                ),
                ProductTitleField(
                  title: LocaleKeys.mealNameAr.tr(),
                ),
                ProductTextField(
                  controller: cubit.productNameAr,
                ),
                ProductTitleField(
                  title: LocaleKeys.category.tr(),
                ),
                verticalSpace(8),
                const ProductCategoriesWidget(),
                ProductTitleField(
                  title: '${LocaleKeys.discount.tr()}%',
                ),
                ProductTextField(
                  controller: cubit.productDisCount,
                  textInputType: TextInputType.number,
                ),
                ProductTitleField(
                  title: LocaleKeys.description.tr(),
                ),
                ProductTextField(
                  borderRadius: 16,
                  maxLines: 3,
                  contentHorizontalPadding: 10,
                  controller: cubit.productDescription,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
                ProductTitleField(
                  title: LocaleKeys.descriptionAr.tr(),
                ),
                ProductTextField(
                  controller: cubit.productDescriptionAR,
                  textInputType: TextInputType.multiline,
                  maxLines: 3,
                  borderRadius: 16,
                  contentHorizontalPadding: 10,
                  textInputAction: TextInputAction.newline,
                ),
                verticalSpace(15),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: backGroundGray,
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 7)
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizeProductWidget(),
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: backGroundGray,
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 7)
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ExtraWidget(),
                      )),
                ),
                verticalSpace(10),
                ProductImageAndButtonWidget(
                  type: 'add',
                  isOffer: widget.isOffer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
