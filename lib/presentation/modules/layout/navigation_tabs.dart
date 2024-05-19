import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_screen.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/orders_screen.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/profits/profits.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/tabs/tab.dart';
import '../../../core/assets_constant/images.dart';
import 'screens/home/home_screen.dart';


class NavigationTabs {
  /// Default constructor is private because this class will be only used for
  /// static fields and you should not instantiate it.
  NavigationTabs._();


  static const home = 0;
  static const profits = 1;
  static const store   = 2;
  static const profile= 3;

}
getDataTabs(){
  List<NavigationTab> kTabs =  <NavigationTab>[
    NavigationTab(
      name:LocaleKeys.home.tr(),
      image: AppImages.holder,
      unSelectIcon:  CupertinoIcons.house,
      selectIcon:CupertinoIcons.house_fill,
      initialRoute: const HomeScreen(),
      index: NavigationTabs.home,
    ),
    NavigationTab(
      name:LocaleKeys.profits.tr(),
      image: AppImages.holder ,
      unSelectIcon:Icons.bar_chart_sharp  ,
      selectIcon:  Icons.insert_chart,
      initialRoute: const ProfitsScreen(),
      index: NavigationTabs.profits,
    ),
    NavigationTab(
      name:LocaleKeys.orders.tr(),
      image: AppImages.holder ,
      // selectIcon: CupertinoIcons.square_list_fill,
      // unSelectIcon: CupertinoIcons.square_list,
      selectIcon: Icons.store_mall_directory,
      unSelectIcon: Icons.store_mall_directory_outlined,
      initialRoute: const OrdersScreen(),
      index: NavigationTabs.store ,
    ),

    NavigationTab(
      name: LocaleKeys.myAccount.tr(),
      image: AppImages.holder ,
      selectIcon: Icons.person,
      unSelectIcon: Icons.person_outline_rounded,
      initialRoute: const AccountScreen(),
      index: NavigationTabs.profile ,
    ),
  ];
  return kTabs;
}


