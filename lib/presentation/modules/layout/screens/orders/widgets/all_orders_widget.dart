import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/assets_constant/images.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../component/custom_not_found_data.dart';

class AllOrdersWidget extends StatelessWidget {
  const AllOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersCubit cubit =OrdersCubit.get();
    return   Container(
      color: customWhite,
      width: double.infinity,
      child: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(cubit.ordersModel!=null){
            if(cubit.ordersModel!.data!.isNotEmpty){
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                    itemCount: cubit.ordersModel!.data!.length ,
                    itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.h),
                    child: OrderItem(ordersModelData: cubit.ordersModel!.data![index],),
                  );
                }),
              );
            }
            else{
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomNotFoundDataWidget(image: AppImages.notFoundBranch,title: LocaleKeys.notFoundData.tr(), type: 'svg',),
              );
            }
          }
          else{
            return  const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
