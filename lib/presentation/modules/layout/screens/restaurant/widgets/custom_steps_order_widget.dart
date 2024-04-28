import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';


class CustomStepsOrderWidget extends StatelessWidget {
  const CustomStepsOrderWidget({super.key, required this.text});
 final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.23,
      child:
      Column(
        children: [
          const Divider(
            color: primaryColor,
            thickness: 10,
            indent: 2,
            endIndent: 2,
          ),
          Text(text,style: TextStyles.font20Black700Weight.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp
          ),),
        ],
      ),
    );
  }
}
