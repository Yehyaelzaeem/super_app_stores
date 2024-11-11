import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/color.dart';
import '../../core/resources/fonts/app_fonts.dart';
import '../../core/resources/styles.dart';
import 'custom_loading_widget.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color? color;
  final double? width;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final Color? fontColor;
  final Color? boxShadowColor;
  final bool? isLoading;

  const PrimaryButtonWidget(
      {super.key,
      required this.onTap,
      required this.text,
      this.color,
      this.borderColor,
      this.fontColor,
      this.boxShadowColor,
      this.width,
      this.height,  this.isLoading, this.radius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: width ?? MediaQuery.of(context).size.width * 0.8,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: 10.w) +
              EdgeInsets.only(top: 10.h, bottom: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical:10.h),
          decoration: BoxDecoration(
              color: color ?? primaryColor,
              borderRadius: BorderRadius.circular( radius?? 20),
              border: Border.all(color: borderColor ?? Colors.white, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: boxShadowColor ?? Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: const Offset(2, 5),
                )
              ]),
          child: Center(
            child:
                isLoading==true
                    ?  CustomLoadingWidget(size: 25,color: Colors.white)
                    :
            Text(
              text ?? '',
              style: TextStyles.font16Black500Weight.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.lateefFont,
                  fontSize: 15,
                  color: fontColor ?? whiteColor),
            ),
          )),
    );
  }
}
