import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../../../../../component/custom_text_field.dart';
import '../../../../auth/widget/custom_title_tab_bar.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:  backGroundGray,
        appBar:  const CustomAppBar(
          color: backGroundGray,
          title: 'الاعدادات',
        ),
        body: Column(
          children: [
            TabBar(
              onTap: (int val) {
              },
              tabs:  <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('اعدادات عامة',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyles.font18Black700Weight.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('اعدادات المطعم',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyles.font18Black700Weight.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ),

              ],
              labelStyle: TextStyles.font15CustomGray400Weight,
              unselectedLabelStyle: TextStyles.font15CustomGray400Weight.copyWith(
                  color: backGroundGray
              ),
              indicatorColor:blueColor,
              labelColor: blueColor,
              indicatorPadding: EdgeInsets.zero,
              unselectedLabelColor: black,
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          verticalSpace(10),
                          CustomTextField(
                            prefixIcon:  const Icon(Icons.menu,color: Colors.grey,),
                            hintText: 'اسم المطعم',
                            hintStyle: TextStyles.font16Black500Weight.copyWith(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w600
                            ),
                            fillColor: whiteColor,
                            controller: TextEditingController(),
                            borderRadius: 40,
                            borderColor: Colors.grey.shade400,
                          ),
                          verticalSpace(20),
                          CustomTextField(
                            prefixIcon:  const Icon(Icons.email,color: Colors.grey,),
                            hintText: ' البريد الالكتروني',
                            hintStyle: TextStyles.font16Black500Weight.copyWith(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w600
                            ),
                            fillColor: whiteColor,
                            controller: TextEditingController(),
                            borderRadius: 40,
                            borderColor: Colors.grey.shade400,
                          ),
                          verticalSpace(20),
                          CustomTextField(
                            prefixIcon:  const Icon(Icons.phone_android,color: Colors.grey,),
                            hintText: 'الموبايل',
                            hintStyle: TextStyles.font16Black500Weight.copyWith(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w600
                            ),
                            fillColor: whiteColor,
                            controller: TextEditingController(),
                            borderRadius: 40,
                            borderColor: Colors.grey.shade400,
                          ),
                          verticalSpace(20),
                          CustomTextField(
                            prefixIcon:  const Icon(Icons.location_on,color: Colors.grey,),
                            hintText: 'العنوان',
                            hintStyle: TextStyles.font16Black500Weight.copyWith(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w600
                            ),
                            suffixIcon: IconButton(onPressed: (){},icon: const Icon(Icons.location_on_outlined,color: Colors.grey,),),
                            fillColor: whiteColor,
                            controller: TextEditingController(),
                            borderRadius: 40,
                            borderColor: Colors.grey.shade400,
                          ),
                          verticalSpace(20),
                          CustomTextField(
                            prefixIcon:  const Icon(Icons.store,color: Colors.grey,),
                            hintText: 'نوع المطعم',
                            hintStyle: TextStyles.font16Black500Weight.copyWith(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w600
                            ),
                            fillColor: whiteColor,
                            controller: TextEditingController(),
                            borderRadius: 40,
                            borderColor: Colors.grey.shade400,
                          ),
                          verticalSpace(50),
                          Container(
                            height: 43,
                            decoration: Decorations.backGroundDecorationButton().copyWith(
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: CustomElevatedButton(
                              backgroundColor: Colors.transparent,
                              onTap: (){
                              },
                              buttonText:'تم',
                              width: MediaQuery.of(context).size.width*0.5,
                              height: 35,
                              fontSize: 17,
                              borderRadius: 40,
                            ),
                          ),
                          verticalSpace(50),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                    child: Column(
                      children: [
                        verticalSpace(10),
                        CustomTextField(
                          contentHorizontalPadding: 25.w,
                          hintText: 'وقت تحضير الطلب',
                          hintStyle: TextStyles.font16Black500Weight.copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600
                          ),
                          fillColor: whiteColor,
                          controller: TextEditingController(),
                          borderRadius: 40,
                          borderColor: Colors.grey.shade400,
                        ),
                        verticalSpace(20),
                        CustomTextField(
                          contentHorizontalPadding: 25.w,
                          hintText: 'الحد الاقصي للعناصر',
                          hintStyle: TextStyles.font16Black500Weight.copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600
                          ),
                          fillColor: whiteColor,
                          controller: TextEditingController(),
                          borderRadius: 40,
                          borderColor: Colors.grey.shade400,
                        ),
                        verticalSpace(20),
                        CustomTextField(
                          contentHorizontalPadding: 25.w,
                          hintText: 'الحد الادني لسعر الطلب',
                          hintStyle: TextStyles.font16Black500Weight.copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600
                          ),
                          fillColor: whiteColor,
                          controller: TextEditingController(),
                          borderRadius: 40,
                          borderColor: Colors.grey.shade400,
                        ),
                        verticalSpace(20),
                        CustomTextField(
                          contentHorizontalPadding: 25.w,
                          hintText: 'تحديد نوع مقدم الخدمة',
                          hintStyle: TextStyles.font16Black500Weight.copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600
                          ),
                          fillColor: whiteColor,
                          controller: TextEditingController(),
                          borderRadius: 40,
                          borderColor: Colors.grey.shade400,
                        ),
                        verticalSpace(50),
                        Container(
                          height: 43,
                          decoration: Decorations.backGroundDecorationButton().copyWith(
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: CustomElevatedButton(
                            backgroundColor: Colors.transparent,
                            onTap: (){
                            },
                            buttonText:'تم',
                            width: MediaQuery.of(context).size.width*0.5,
                            height: 35,
                            fontSize: 17,
                            borderRadius: 40,
                          ),
                        ),
                        verticalSpace(50),
                      ],
                    ),
                  )
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
