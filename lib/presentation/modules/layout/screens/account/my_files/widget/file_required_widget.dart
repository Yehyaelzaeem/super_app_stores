import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';

class FileRequiredWidget extends StatelessWidget {
  const FileRequiredWidget({super.key, required this.title, required this.text, required this.onTap});
  final String title;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        color: whiteColor,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: TextStyles.font18Black700Weight.copyWith(
                      color: backBlue2
                  ),),
                  Text(text,style: TextStyles.font18Black700Weight.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                  ),),
                ],
              ),
              Row(
                children: [
                  InkWell(
                      onTap: onTap,
                      child: const Icon(Icons.file_upload_outlined,color: customGray,)),
                  horizontalSpace(10),
                  const Icon(Icons.info,color: redColor,),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
