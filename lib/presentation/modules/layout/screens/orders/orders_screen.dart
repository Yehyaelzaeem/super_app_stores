import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/domain/logger.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/accepted_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/all_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/order_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/translations/locale_keys.dart';
import '../../../../component/custom_app_bar.dart';
import '../../../../component/custom_not_found_data.dart';
import '../../../../component/switch/custom_switch.dart';
import '../../../../component/tabview/tabbar_widget.dart';
import '../../../branches/branch_cubit.dart';

class OrdersScreen extends StatelessWidget{
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrdersCubit cubit =OrdersCubit.get();
    ProfileCubit profileCubit =ProfileCubit.get(context);
    BranchCubit.get().getLocation(context);

    cubit.getAllOrders();
    return Scaffold(
        appBar:
        CustomAppBar(
            title: 'متاح الان',
            isBackButtonExist: false,
            actions: [
              BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if(profileCubit.profileModel!=null){
                      return  CustomSwitch(
                        height: 27,
                        width: 50,
                        onToggle: (bool x) {
                          cubit.changeStateRestaurant();
                      }, value: profileCubit.profileModel?.status=='available'?true:false,);
                    }else{
                      return const CustomLoadingWidget();
                    }
                  },
                ),
              SizedBox(width: 17.w,),
            ]

        ),
        body:
        Column(
          children: [
            Expanded(
              child: TabBarWidget(tabs: [
                TabItemModel(
                    label: LocaleKeys.orders.tr(),
                    page: const AllOrdersWidget()),
                TabItemModel(
                    label: LocaleKeys.acceptOrders.tr(),
                    page:  const AcceptedOrdersWidget()
                ),
              ]),
            ),
          ],
        )
        //CustomCalender





    );
  }
}
