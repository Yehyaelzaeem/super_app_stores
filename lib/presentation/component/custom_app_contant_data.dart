
import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/main.dart';
import 'package:cogina_restaurants/presentation/component/custom_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/resources/color.dart';
import '../../core/resources/styles.dart';

class CustomAppContData extends StatelessWidget {
  const CustomAppContData({super.key, required this.image, required this.title, required this.des});
 final String image;
 final String title;
 final String des;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h,),
          Center(
            child: SizedBox(
                height: 130.w,
                width: 130.w,
                child:
                    isWeltApp==true?
                const CustomLogo():
                Image.asset(AppImages.logo2,fit: BoxFit.cover,),
            ),
          ),
          Text(
           title,
            style: TextStyles.font18Black700Weight.copyWith(
                color: black
            ),),
          verticalSpace(16),
          Text(
            des,
            style: TextStyles.font15CustomGray400Weight.copyWith(
                color: customGray,
              fontWeight: FontWeight.w700
            ),
          textAlign: TextAlign.start,),
        ],
      ),
    );
  }
}
