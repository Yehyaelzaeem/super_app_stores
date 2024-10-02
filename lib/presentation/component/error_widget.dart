import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/resources/color.dart';

class ErrorNetworkWidget extends StatelessWidget {
  final void Function() onTap;
  const ErrorNetworkWidget({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Try again later',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 15.sp),),
            horizontalSpace(10),
            Icon(Icons.refresh_rounded, color: Colors.grey, size: 20.w,),
          ],
        ),
        verticalSpace(15),
        GestureDetector(
          onTap:onTap,
          child:  Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Text('Again',style: TextStyle(color: Colors.white),),
          ),
        )

      ],
    );
  }
}
