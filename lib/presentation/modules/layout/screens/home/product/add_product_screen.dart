import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/extra_add_item_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/prodcut_categories_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/product/widgets/product_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../data/model/response/extra_model.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../home_cubit.dart';
import 'widgets/extra_title_widget.dart';
import 'widgets/product_text_field.dart';
import 'widgets/product_title_field.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    HomeCubit cubit =HomeCubit.get(context);
    cubit.removeProductTextFieldData();
    cubit.productDisCount=TextEditingController(text: '0');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);

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
                 ProductTitleField(title: '${LocaleKeys.discount.tr()}%',),
                ProductTextField(controller: cubit.productDisCount,
                  textInputType: TextInputType.number,),
                 ProductTitleField(title: LocaleKeys.description.tr(),),
                ProductTextField(controller: cubit.productDescription,
                textInputType: TextInputType.multiline,
                ),
                verticalSpace(10),
                BlocConsumer<HomeCubit, HomeState>(
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
                                                                contentHorizontalPadding:20,
                                                                textInputType: TextInputType.number,notValidation: true,),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    verticalSpace(5),
                                                    Center(
                                                      child: CustomElevatedButton(
                                                        isLoading:state is ExtraModelLoadingState,
                                                        backgroundColor: primaryColor.withOpacity(0.1),
                                                        onTap: (){
                                                          if(cubit.extraFormKey.currentState!.validate()){
                                                            ExtraModel extraModel =
                                                            ExtraModel(nameAr: cubit.productExtraNameAr.text,
                                                                nameEn: cubit.productExtraName.text, price: double.parse(cubit.productExtraPrice.text));
                                                             cubit.addExtra(extraModel);
                                                          }

                                                        },
                                                        buttonText:LocaleKeys.add.tr(),
                                                        width: MediaQuery.of(context).size.width*0.3,
                                                        height: 40,
                                                        fontSize: 17,
                                                        fontColor: primaryColor,
                                                        borderRadius: 40,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                        },
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
