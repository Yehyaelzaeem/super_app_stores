import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../core/translations/locale_keys.dart';
import 'product_title_field.dart';

class ExtraTitleWidget extends StatelessWidget {
  const ExtraTitleWidget({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child:
            Center(child: ProductTitleField(title: LocaleKeys.addition.tr(),)),
          ),
          horizontalSpace(5),
          Expanded(
            child:
            Center(child: ProductTitleField(title:LocaleKeys.additionArabic.tr(),)),
          ),
          horizontalSpace(5),
          Expanded(
            child:
            Center(child: ProductTitleField(title: LocaleKeys.extraPrice.tr(),)),
          ),
        ],
      ),
    );
  }
}
