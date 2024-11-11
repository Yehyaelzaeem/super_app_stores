import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../component/custom_text_field.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({super.key, required this.controller, this.textInputType, this.notValidation, this.width, this.contentHorizontalPadding, this.textInputAction, this.validationFunc, this.maxLines, this.borderRadius,});
 final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? notValidation;
  final double? width;
  final int? maxLines;
  final double? borderRadius;
  final String? Function(String?)? validationFunc;
  final double? contentHorizontalPadding;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 12.h,bottom: 16.h),
      child:
      StatefulBuilder(builder: (context,setState){
        return CustomTextField(

          maxLines:maxLines?? 0,
          textInputType: textInputType,
          textInputAction: textInputAction,
          validationFunc:
          validationFunc??
              (value) {
            if (value == null || value.isEmpty) {
              if(notValidation==true){
                return '   ${LocaleKeys.thisField.tr()} \n     ${LocaleKeys.required.tr()}';

              }else{
                return LocaleKeys.requiredField.tr();

              }
            }
            return null;
          },
          contentHorizontalPadding:contentHorizontalPadding?? 30,
          hintText: '',
          hintStyle: TextStyles.font16Black500Weight.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600
          ),
          fillColor: whiteColor,
          controller: controller,
          borderRadius: borderRadius??40,
          borderColor: Colors.grey.shade400,
        );

      },)
    );
  }
}
