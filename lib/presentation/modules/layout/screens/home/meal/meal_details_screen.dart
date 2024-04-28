import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:cogina_restaurants/core/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/assets_constant/images.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundGray,
       appBar:const CustomAppBar(
           color: backGroundGray,
           title: 'تفاصيل الوجبة',
       ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: whiteColor,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Image.asset(AppImages.pro2),
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('باستا خضراوات',style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2
                      ),),
                      Row(
                        children: [
                          const Icon(Icons.flag_rounded,color: backBlue2,size: 25,),
                          Text(' 25 دينار',style: TextStyles.font18Black700Weight.copyWith(
                              color: backBlue2
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Text('برجر _ سندوتشات',style: TextStyles.font18Black700Weight.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                  )),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('الخصم',style: TextStyles.font18Black700Weight.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      )),
                      Text('20%',style: TextStyles.font18Black700Weight.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      )),
                    ],
                  ),
                  verticalSpace(10),
                  Text('الوصف',style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    color: backBlue2
                  )),
                  verticalSpace(10),
                  Text('برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات برجر _ سندوتشات ',style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                  )),
                  verticalSpace(10),
                  Text('الاضافات',style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: backBlue2
                  )),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('صلصه طماطم',style: TextStyles.font18Black700Weight.copyWith(
                        fontSize: 15
                      ),),
                      Text(' 12 دينار',style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2,
                          fontSize: 15

                      ),),
                    ],
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('صلصه طماطم',style: TextStyles.font18Black700Weight.copyWith(
                          fontSize: 15
                      ),),
                      Text(' 12 دينار',style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2,
                          fontSize: 15

                      ),),
                    ],
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('صلصه طماطم',style: TextStyles.font18Black700Weight.copyWith(
                          fontSize: 15
                      ),),
                      Text(' 12 دينار',style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2,
                          fontSize: 15

                      ),),
                    ],
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('صلصه طماطم',style: TextStyles.font18Black700Weight.copyWith(
                          fontSize: 15
                      ),),
                      Text(' 12 دينار',style: TextStyles.font18Black700Weight.copyWith(
                          color: backBlue2,
                          fontSize: 15

                      ),),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
