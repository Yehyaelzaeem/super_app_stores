import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_screen.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/profits/profits.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/restaurant/provider_restaurant.dart';
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

const List<NavigationTab> kTabs = <NavigationTab>[
  NavigationTab(
    name:'home',
    image: AppImages.holder,
    unSelectIcon:  CupertinoIcons.house,
    selectIcon:CupertinoIcons.house_fill,
    initialRoute: HomeScreen(),
    index: NavigationTabs.home,
  ),
  NavigationTab(
    name: 'profits',
    image: AppImages.holder ,
    unSelectIcon:Icons.bar_chart_sharp  ,
    selectIcon:  Icons.insert_chart,
    initialRoute: ProfitsScreen(),
    index: NavigationTabs.profits,
  ),
  NavigationTab(
    name: 'order',
    image: AppImages.holder ,
    // selectIcon: CupertinoIcons.square_list_fill,
    // unSelectIcon: CupertinoIcons.square_list,
    selectIcon: Icons.store_mall_directory,
    unSelectIcon: Icons.store_mall_directory_outlined,
    initialRoute: RestaurantScreen(),
    index: NavigationTabs.store ,
  ),

  NavigationTab(
    name: 'account',
    image: AppImages.holder ,
    selectIcon: Icons.person,
    unSelectIcon: Icons.person_outline_rounded,
    initialRoute: AccountScreen(),
    index: NavigationTabs.profile ,
  ),
];
