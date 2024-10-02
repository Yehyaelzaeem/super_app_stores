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

class AcceptedOrdersWidget extends StatefulWidget {
  const AcceptedOrdersWidget({super.key});

  @override
  State<AcceptedOrdersWidget> createState() => _State();
}

class _State extends State<AcceptedOrdersWidget> {
  OrdersCubit cubit = OrdersCubit.get();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print('initState');
    cubit.getAcceptedOrders(status: 'restaurant_accepted',);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !cubit.isLoading) {
        cubit.getAcceptedOrders(status: 'restaurant_accepted');
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
          if (state.acceptOrderState == RequestState.error) {
            return ErrorNetworkWidget(onTap: () {
              cubit.getAcceptedOrders(status: 'restaurant_accepted');
            });
          }
          else if (state.acceptOrderState == RequestState.loaded) {
            if (state.acceptOrdersList.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.acceptOrdersList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.acceptOrdersList.length) {
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
                          ordersModelData: state.acceptOrdersList[index],
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
          else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }

}

