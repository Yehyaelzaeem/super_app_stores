import 'package:cogina_restaurants/core/resources/fonts/app_fonts.dart';
import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/accepted_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/completed_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/delivered_driver_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/on_progress_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/padding_orders_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/widgets/rejected_orders_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/translations/locale_keys.dart';
import '../../../../component/drop_down.dart';
import '../../../../component/switch/custom_switch.dart';
import '../../../../component/tabview/tabbar_widget.dart';
import '../../../branches/branch_cubit.dart';
import '../../../prescription/prescription_cubit.dart';
import '../../../prescription/prescription_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  BranchCubit branchCubit = BranchCubit.get();

  @override
  void initState() {
    branchCubit.getLocation(context);
    branchCubit.getBranches();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit =ProfileCubit.get(context);
    OrdersCubit cubit =OrdersCubit.get();
    return
      Scaffold(
        appBar:
            AppBar(
              toolbarHeight: 80,
              title:
              BlocConsumer<BranchCubit, BranchState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if(branchCubit.branchesModel!=null && branchCubit.branchesModel?.data!=null){
                    if(branchCubit.branchesModel!.data!.isNotEmpty){
                      return   DropDownField(
                        hint: LocaleKeys.branches.tr(),
                        valueId:cubit.branchId ,
                        items: branchCubit.branchesModel!.data!.map((e) => DropDownItem(id: e.id.toString(), title: e.name)).toList(),
                        onChanged: (DropDownItem? value) {
                          // setState(() {
                          //   cubit.branchId=value?.id??'0';
                          // });
                          cubit.changeBranch(value?.id??'0');

                        },
                      );
                    }else{
                      return SizedBox.shrink();
                    }
                  }else{
                    return SizedBox.shrink();
                  }

                },
              ),
              centerTitle: true,
              actions: [
                 Text('متاح الان',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: AppFonts.lateefFont,),),
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
              ] ,
            ),

        body:

        Column(
          children: [
            Expanded(
              child:
              (profileCubit.profileModel?.store?.storeType?.id??0)==2?
              TabBarWidget(
                  tabs: [
                    OrdersTabsTopWidget(isUnderLine: true),
                    TabItemModel(
                        label: LocaleKeys.prescriptions.tr(),
                        page:  RefreshIndicator(
                          onRefresh: ()async{
                            await Future.delayed(const Duration(seconds: 1));
                            PrescriptionCubit cubit = context.read<PrescriptionCubit>();
                            cubit.getPrescription();
                          },
                          child: PrescriptionScreen(),
                        )
                    )
                  ]):
              OrdersTabs(),

            ),
          ],
        )
    );
  }
  TabItemModel OrdersTabsTopWidget({bool isUnderLine=false}){
    OrdersCubit cubit =OrdersCubit.get();
    return TabItemModel(
        label: LocaleKeys.orders.tr(),
        page:  RefreshIndicator(
          onRefresh: ()async{

          },
          child:  Container(
              child:
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                  ),
                  Expanded(child:
                  OrdersTabs(isUnderLine: isUnderLine))
                ],
              )
          ),
        ));
  }
  Widget OrdersTabs({bool isUnderLine=false}){
    OrdersCubit cubit =OrdersCubit.get();
    return TabBarWidget(
        isUnderLine: isUnderLine,
        tabs: [
          TabItemModel(
              label: LocaleKeys.newOrder.tr(),
              page:  RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(const Duration(seconds: 1));
                  cubit.getPendingOrders(status: 'padding',isReload: true);
                },
                child: PaddingWidget(),
              )),
          TabItemModel(
              label: LocaleKeys.currentOrders.tr(),
              page:  RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(const Duration(seconds: 1));
                  cubit.getAcceptedOrders(status: 'restaurant_accepted',isReload: true);
                },
                child: AcceptedOrdersWidget(),
              )
          ),
          TabItemModel(
              label: LocaleKeys.preparation.tr(),
              page:  RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(const Duration(seconds: 1));
                  cubit.getOnProgressOrders(status: 'restaurant_order_progress',isReload: true);
                },
                child: OnProgressOrdersWidget(),
              )
          ),
          TabItemModel(
              label: LocaleKeys.delivered2.tr(),
              page:  RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(const Duration(seconds: 1));
                  cubit.getOnWayOrders(status: 'restaurant_done',isReload: true);
                },
                child: DeliveredDeliverOrdersWidget(),
              )
          ),
          TabItemModel(
              label: LocaleKeys.completed.tr(),
              page:  RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(const Duration(seconds: 1));
                  cubit.getCompletedOrders(status: 'restaurant_delivered_driver',isReload: true);
                },
                child: CompletedOrdersWidget(),
              )
          ),
          TabItemModel(
              label: LocaleKeys.rejected.tr(),
              page: RefreshIndicator(
                onRefresh: ()async{
                  await Future.delayed(const Duration(seconds: 1));
                  cubit.getRejectedOrders(status: 'restaurant_rejected',isReload: true);
                },
                child: RejectedOrdersWidget(),
              )
          ),
        ]);
  }
}



