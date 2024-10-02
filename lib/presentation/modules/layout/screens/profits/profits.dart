import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/assets_constant/images.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../../core/resources/decoration.dart';
import '../../../../../core/translations/locale_keys.dart';
import '../../../../component/custom_app_bar.dart';
import '../../../../component/custom_elevated_button.dart';
import '../../../../component/custom_not_found_data.dart';
import '../../../../component/cutsom_calendar.dart';
import '../../../orders/widgets/order_provider_item.dart';

class ProfitsScreen extends StatelessWidget {
  const ProfitsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    OrdersCubit cubit =OrdersCubit.get();
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'سجل الارباح',
        isBackButtonExist: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150.h,
            child: Stack(
              children: [
                Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    boxShadow: [BoxShadow(color: Colors.black38,blurRadius: 5)]
                  ),
                  child:BlocConsumer<OrdersCubit, OrdersState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if(cubit.ordersByDate!=null){
                            if(cubit.ordersByDate!.data!.isNotEmpty){
                              var total = 0.0;
                              try{
                                total= cubit.ordersByDate!.data!
                                    .map((e) => double.parse(e.orderTotal.toString()))
                                    .toList()
                                    .fold(0.0, (previousValue, element) => previousValue + element);
                              }catch(e){

                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text('$total ${LocaleKeys.lyd.tr()}',style: TextStyles.font20Black700Weight.copyWith(
                                  //     color: backBlue2
                                  // ),),
                                  // Text('اجمالي الارباح',style: TextStyles.font16Black600Weight),
                                ],
                              );
                            }else{
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('0.0 ${LocaleKeys.currency.tr()}',style: TextStyles.font20Black700Weight.copyWith(
                                      color: backBlue2
                                  ),),
                                  Text('اجمالي الارباح',style: TextStyles.font16Black600Weight),
                                ],
                              );
                            }

                          }else{
                            return const SizedBox();
                          }

                        },
                      ),
                ),
              ],
            ),
          ),
          const CustomCalender(),
          verticalSpace(20),
          Expanded(
            child: BlocConsumer<OrdersCubit, OrdersState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if(cubit.ordersByDate!=null){
                                if(cubit.ordersByDate!.data!.isNotEmpty){
                                return ListView.builder(
                                    itemCount:cubit.ordersByDate!.data!.length ,
                                    itemBuilder: (context,index){
                                      return Padding(
                                        padding:  EdgeInsets.symmetric(vertical: 5.h),
                                        child: OrderProviderItem(isProfits: true,ordersModelData:cubit.ordersByDate!.data![index] ,),
                                      );
                                  });
                                }else{
                                  return Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                                    child: CustomNotFoundDataWidget(image: AppImages.notFoundBranch,title: LocaleKeys.notFoundData.tr(), type: 'svg',),
                                  );
                                }
                              }else{
                                return const CustomLoadingWidget();
                              }
                            },
                          ),
          )
        ],
      ),
    );
  }
}
