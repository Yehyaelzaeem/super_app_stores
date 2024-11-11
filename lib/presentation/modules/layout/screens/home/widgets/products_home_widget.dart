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
        if(cubit.filterHomeModel!=null&&cubit.filterHomeModel!.productsModel!=null&&cubit.filterHomeModel!.productsModel!.data!=null){
          if(cubit.filterHomeModel!.productsModel!.data!.isNotEmpty){
            return  ListView.builder(
                itemCount:cubit.filterHomeModel!.productsModel!.data!.length,
                itemBuilder: (context,index){
              return MealItemWidget(product: cubit.filterHomeModel!.productsModel!.data![index]);
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
