import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/decoration.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../../../../../component/custom_text_field.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'تواصل معنا',
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(20),
              CustomTextField(
                prefixIcon: const Icon(Icons.person, color: Colors.grey,),
                hintText: 'الاسم',
                hintStyle: TextStyles.font16Black500Weight.copyWith(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600
                ),
                fillColor: whiteColor,
                controller: TextEditingController(),
                borderRadius: 40,
                borderColor: Colors.grey.shade400,
              ),
              verticalSpace(20),
              CustomTextField(
                prefixIcon: const Icon(Icons.email, color: Colors.grey,),
                hintText: 'البريد الالكتروني',
                hintStyle: TextStyles.font16Black500Weight.copyWith(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600
                ),
                fillColor: whiteColor,
                controller: TextEditingController(),
                borderRadius: 40,
                borderColor: Colors.grey.shade400,
              ),
              verticalSpace(20),
              CustomTextField(
                prefixIcon: const Icon(
                  Icons.info, color: Colors.grey,),
                hintText: 'المحتوى',
                hintStyle: TextStyles.font16Black500Weight.copyWith(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600
                ),
                fillColor: whiteColor,
                controller: TextEditingController(),
                borderRadius: 40,
                borderColor: Colors.grey.shade400,
              ),
              verticalSpace(100),
              Container(
                height: 43,
                decoration: Decorations.backGroundDecorationButton().copyWith(
                    borderRadius: BorderRadius.circular(40)
                ),
                child: CustomElevatedButton(
                  backgroundColor: Colors.transparent,
                  onTap: () {},
                  buttonText: 'ارسال',
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                  height: 35,
                  fontSize: 17,
                  borderRadius: 40,
                ),
              ),
              verticalSpace(20),


            ],
          ),
        ),
      ),
    );
  }
}
