import 'package:cogina_restaurants/presentation/component/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final double? borderRadius;
  final Color? fontColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? isLoading;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.borderRadius,
    this.fontColor,
    this.fontSize,
    this.borderColor,
    this.backgroundColor,this.height, this.width, this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isLoading==true) {
          return null;
        }
        onTap();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width??20,height?? 30), // Set your desired width and height
        elevation: 0,
        backgroundColor: backgroundColor ?? primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      ),
      child:
      isLoading==true? SizedBox(
          // height: height?? 45,
          width:  width??20,
          child: const Center(child: CustomLoadingWidget(color: whiteColor,size: 30,),)):
      Text(
        buttonText,
        style: TextStyle(
          color: fontColor ?? whiteColor,
          fontSize: fontSize ?? 13.sp,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
