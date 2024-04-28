import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/widgets/custom_item.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/home/widgets/meal_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/decoration.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../component/custom_app_bar.dart';
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
    return  SafeArea(
      child: Scaffold(
        appBar:  CustomAppBar(
          color: backGroundGray,
          title: 'المطعم',
          isBackButtonExist: false,
          actions: [
            IconButton(
                onPressed: (){
                  context.pushNamed(Routes.notificationScreen);
                },
                icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: whiteColor,
                        boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 5,
                            offset: Offset(1, 4)
                        )]
                    ),
                    child:  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.notifications_active_outlined,color: primaryColor,),
                    )))
          ],
        ),
        backgroundColor: backGroundGray,
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(25),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16.w),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   Text('اقسام المطعم',
                     style: TextStyles.font20Black700Weight.copyWith(
                         color: backBlue2,
                         fontSize: 26
                     ),
                   ),
                   verticalSpace(20),
                   const Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       CustomItem(text: 'بيتزا',),
                       CustomItem(text: 'فطير',),
                       CustomItem(text: 'برجر',),
                       CustomItem(text: 'كشري',)
                     ],
                   ),
                 ],),
               ),
              verticalSpace(35),
              Row(children: [
                horizontalSpace(16),
                Text('الوجبات',
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
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                    )
                  ),
                  child: InkWell(
                      onTap: (){
                        context.pushNamed(Routes.addMealScreen);
                      },
                      child: const Icon(Icons.add,size: 25,color: Colors.white,)),
                )
              ],),
              verticalSpace(20),
              const MealItemWidget(title: 'تشكن برجر', des: 'برجر-سندوتشات', price: '55 دينار', image: AppImages.pro1),
              verticalSpace(20),
              const MealItemWidget(title: 'بيتزا خضار', des: 'بيتزا-فطائر', price: '95 دينار', image: AppImages.pro2),
              verticalSpace(20),
              const MealItemWidget(title: 'باستا بالجمبري', des: 'مكرونات-طواجن', price: '105 دينار', image: AppImages.bur1),
            ],
          ),
        ),
      ),
    );

  }
}
