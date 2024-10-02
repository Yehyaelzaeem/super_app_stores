import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/assets_constant/images.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../component/custom_not_found_data.dart';
import '../../../../../../core/utils/toast_states/enums.dart';
import '../../../../../component/error_widget.dart';

class DeliveredDeliverOrdersWidget extends StatefulWidget {
  const DeliveredDeliverOrdersWidget({super.key});

  @override
  State<DeliveredDeliverOrdersWidget> createState() => _State();
}

class _State extends State<DeliveredDeliverOrdersWidget> {
  OrdersCubit cubit = OrdersCubit.get();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    cubit.getOnWayOrders(status: 'restaurant_done');

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !cubit.isPaginationOnWayLoading) {
        cubit.getOnWayOrders(status: 'restaurant_done');
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: customWhite,
      width: double.infinity,
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.onWayState == RequestState.error) {
            return ErrorNetworkWidget(onTap: () {
              cubit.getOnWayOrders(status: 'restaurant_done');
            });
          }
          else if (state.onWayState == RequestState.loading) {
            return const CustomLoadingWidget();
          }
          else {
            if (cubit.onWayOrdersList.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: cubit.onWayOrdersList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == cubit.onWayOrdersList.length) {
                      return
                        //   cubit.isPaginationLoading
                        //     ? Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Center(
                        //     child: CustomLoadingWidget(),
                        //   ),
                        // )
                        //     :
                        SizedBox.shrink();
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 2.w),
                        child: OrderItem(
                          ordersModelData: cubit.onWayOrdersList[index],
                        ),
                      );
                    }
                  },
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: CustomNotFoundDataWidget(
                  image: AppImages.notFoundBranch,
                  title: LocaleKeys.notFoundData.tr(),
                  type: 'svg',
                ),
              );
            }
          }
        },
      ),
    );
  }

}

