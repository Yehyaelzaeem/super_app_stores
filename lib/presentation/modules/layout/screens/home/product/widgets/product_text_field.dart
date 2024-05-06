import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../component/custom_text_field.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({super.key, required this.controller, this.textInputType, this.notValidation,});
 final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? notValidation;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 5.h,bottom: 10.h),
      child: CustomTextField(
        maxLines: 0,
        textInputType: textInputType,
        validationFunc:notValidation==true?null: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
        contentHorizontalPadding: 30,
        hintText: '',
        hintStyle: TextStyles.font16Black500Weight.copyWith(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600
        ),
        fillColor: whiteColor,
        controller: controller,
        borderRadius: 40,
        borderColor: Colors.grey.shade400,
      ),
    );
  }
}
