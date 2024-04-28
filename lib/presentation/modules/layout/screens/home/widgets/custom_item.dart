import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
class CustomItem extends StatelessWidget {
  const CustomItem({super.key, required this.text});
 final String text;
  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: BoxDecoration(
          color: backGroundGray,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12)
      ),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 3.w),
        child:  Center(
          child: Text(text,
            style: TextStyles.font18Black700Weight.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 17
            ),
          ),
        ),
      ) ,
    );
  }
}
