import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color.dart';
import 'fonts/app_fonts.dart';
class TextStyles{
  static TextStyle font16PrimaryColor700Weight =  TextStyle(
      fontSize: 21.sp,
      fontFamily: AppFonts.lateefFont,
      fontWeight: FontWeight.w700,
      color: primaryColor
  );
  static TextStyle font14White500Weight =  const TextStyle(
      fontSize: 14,
      fontFamily: AppFonts.lateefFont,

      fontWeight: FontWeight.w500,
      color: Colors.white
  );  static TextStyle font16Black500Weight = const TextStyle(
      fontFamily: AppFonts.lateefFont,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black
  );
  static TextStyle font10CustomGray400Weight = const TextStyle(
      fontFamily:  AppFonts.lateefFont,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: customGray
  );
  static TextStyle font18Black700Weight = const TextStyle(
      fontSize: 18,
      fontFamily:  AppFonts.lateefFont,
      fontWeight: FontWeight.w700,
      color: Colors.black
  );
  static TextStyle font15CustomGray400Weight = const TextStyle(
      fontSize: 15,
      fontFamily:  AppFonts.lateefFont,

      fontWeight: FontWeight.w400,
      color: customGray
  );
  static TextStyle font16Black600Weight =  const TextStyle(
      fontSize: 16,
      fontFamily: AppFonts.lateefFont,

      fontWeight: FontWeight.w600,
      color: Colors.black
  );
  static TextStyle font20Black700Weight =  TextStyle(
      fontSize: 20.sp,
      fontFamily:  AppFonts.lateefFont,
      fontWeight: FontWeight.w700,
      color: Colors.black
  );
}