import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';



class CustomTextRowCartWidget extends StatelessWidget {
  const CustomTextRowCartWidget({super.key, required this.title, required this.text, this.horizontal, this.vertical});
  final String title;
  final String text;
  final double? horizontal;
  final double? vertical;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal??35.w,vertical:vertical?? 16.w),
      child: Row(
        children: [
          Text('$title:',
          style: TextStyles.font16Black600Weight,
          ),
          const Spacer(),
          Text(text,
            style: TextStyles.font16Black600Weight.copyWith(
              color: redColor.withOpacity(0.5)
            ),
          ),
        ],
      ),
    );
  }
}
