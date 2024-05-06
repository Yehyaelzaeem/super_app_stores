import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/widgets/custom_item.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/widgets/custom_shimmer_meal.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/widgets/meal_item_widget.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/widgets/products_home_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/decoration.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../component/custom_app_bar.dart';
import 'home_cubit.dart';
// _getData(BuildContext context){
//   BlocProvider.of<HomeCubit>(context, listen: false).getOffers();
// }
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // _getData(context);
  }
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit =HomeCubit.get(context);
    return  SafeArea(
      child: Scaffold(
        appBar:  CustomAppBar(
          color: backGroundGray,
          title: LocaleKeys.restaurant.tr(),
          isBackButtonExist: false,
          actions: [
            IconButton(
                onPressed: (){
                  context.pushNamed(Routes.notificationScreen);
                },
                icon: const Icon(Icons.notifications_active_outlined,color: primaryColor,),
                //Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: whiteColor,
//                         boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 5,
//                             offset: Offset(1, 4)
//                         )]
//                     ),
//                     child:  const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child:
//                       Icon(Icons.notifications_active_outlined,color: primaryColor,),
//                     ))
                )
          ],
        ),
        backgroundColor: backGroundGray,
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(25),
             BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if(cubit.homeModel!=null&&cubit.homeModel!.categories!=null&&cubit.homeModel!.categories!.data!.isNotEmpty){
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.restaurantCategories.tr(),
                                style: TextStyles.font20Black700Weight.copyWith(
                                    color: backBlue2,
                                    fontSize: 26
                                ),
                              ),
                              verticalSpace(10),
                               SingleChildScrollView(
                                 scrollDirection: Axis.horizontal,
                                 child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ...cubit.homeModel!.categories!.data!.map((e) =>
                                         CustomItem( categoriesData: e,)
                                    )
                                  ],
                                 ),
                               ),
                            ],),
                        );
                      }else{
                        return const SizedBox.shrink();
                      }
                    },
                  ),
            verticalSpace(25),
            Row(children: [
              horizontalSpace(16),
              Text(LocaleKeys.meals.tr(),
                style: TextStyles.font20Black700Weight.copyWith(
                    color: backBlue2,
                    fontSize: 20
                ),
              ),
              horizontalSpace(5),
              const Icon(Icons.edit_note_outlined),
              const Spacer(),
              Container(
                width: 40.w,
                height: 35.h,
                decoration: Decorations.backGroundDecorationButton().copyWith(
                  borderRadius:  BorderRadius.only(
                    topRight: Radius.circular(context.locale.languageCode.toString()=='ar'?25:0),
                    bottomRight: Radius.circular(context.locale.languageCode.toString()=='ar'?25:0) ,
                      topLeft: Radius.circular(context.locale.languageCode.toString()=='ar'?0:25),
                    bottomLeft: Radius.circular(context.locale.languageCode.toString()=='ar'?0:25),
                  )
                ),
                child: InkWell(
                    onTap: (){
                      cubit.getProductsCategories();
                      context.pushNamed(Routes.addMealScreen);
                    },
                    child: const Icon(Icons.add,size: 25,color: Colors.white,)),
              )
            ],),
             const Expanded(child: ProductsHomeWidget()),
          ],
        ),
      ),
    );

  }
}
