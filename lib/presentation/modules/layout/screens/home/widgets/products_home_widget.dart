import 'package:cogina_restaurants/core/resources/styles.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/assets_constant/images.dart';
import 'custom_shimmer_meal.dart';
import 'meal_item_widget.dart';

class ProductsHomeWidget extends StatelessWidget {
  const ProductsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(cubit.homeModel!=null&&cubit.homeModel!.productsModel!=null){
          final products =cubit.homeModel!.productsModel!.data!;
          if(products.isNotEmpty){
            return  ListView.builder(
                itemCount:products.length,
                itemBuilder: (context,index){
              return MealItemWidget(product: products[index]);
            });
          }else{
            return Column(
              children: [
                Image.asset(AppImages.meal),
                Text(LocaleKeys.notFoundData.tr(),
                style: TextStyles.font18Black700Weight,
                )
              ],
            );

          }
        }else{
          return ListView.builder(
              itemCount: 4,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(top: 18.h),
                  child: const CustomShimmerMeal(),
                );
              });
        }
      },
    );
  }
}
