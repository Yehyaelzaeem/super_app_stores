
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/helpers/spacing.dart';
import '../../core/resources/color.dart';
import '../../core/resources/styles.dart';

class CustomNotFoundDataWidget extends StatelessWidget {
  const CustomNotFoundDataWidget({super.key, required  this.title, required this.type, required this.image, this.onTap});
  final String image;
  final String title;
  final String type;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            type=='png'?
            Container(
                height: 200.h,
                child: Image.asset(image,)):
            Container(
                height: 200.h,
                child: SvgPicture.asset(image,)),
            verticalSpace(10),

            // verticalSpace(50),
            if(onTap!=null)
              InkWell(
                onTap: onTap,
                child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                  decoration: BoxDecoration(
                      color:
                      primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(2, 5),
                        ),
                      ]
                  ),
                  child:   Row(

                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                        style: TextStyles.font18Black700Weight.copyWith(
                            color:whiteColor,
                            fontSize: 10.sp
                        ),
                      ),
                      horizontalSpace(10),
                      Icon(Icons.refresh, color: Colors.white, size: 14.w,),
                    ],
                  ),
                ),
              )
            else
              Text(title,
                style: TextStyles.font18Black700Weight.copyWith(
                    color: customBlack.withOpacity(0.6)
                ),
              ),

          ],
        ),
      );
  }
}
