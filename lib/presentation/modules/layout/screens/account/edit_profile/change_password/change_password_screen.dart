import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../../../core/helpers/spacing.dart';
import '../../../../../../../../core/resources/decoration.dart';
import '../../../../../../component/custom_app_bar.dart';
import '../../../../../../component/custom_elevated_button.dart';
import '../../../../../../component/custom_text_field.dart';


class ChangeProfilePasswordScreen extends StatelessWidget {
  ChangeProfilePasswordScreen({super.key});

  bool isVisible1=true;
  TextEditingController pass=TextEditingController();
  TextEditingController confirm=TextEditingController();
  bool isVisible2=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'تحديث كلمه المرور',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(35),
              StatefulBuilder(builder: (context,setState){
                return CustomTextField(
                  prefixIcon:  const Icon(Icons.lock,color: Colors.grey,),
                  hintText: 'كلمة المرور الجديدة',
                  hintStyle: TextStyles.font16Black500Weight.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600
                  ),
                  fillColor: whiteColor,
                  controller: pass,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                  isPassword: isVisible2,
                  suffixIcon: IconButton(icon:  Icon(
                      isVisible2?
                      Icons.visibility_off:Icons.visibility),onPressed: (){
                    setState(() {
                      isVisible2=!isVisible2;
                    });
                  },),
                );
              }),
              verticalSpace(20),
              StatefulBuilder(builder: (context,setState){
                return CustomTextField(
                  prefixIcon:  const Icon(Icons.lock,color: Colors.grey,),
                  hintText: 'تأكيد كلمة المرور',
                  hintStyle: TextStyles.font16Black500Weight.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600
                  ),
                  fillColor: whiteColor,
                  controller: confirm,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                  isPassword: isVisible1,
                  suffixIcon: IconButton(icon:  Icon(
                      isVisible1?
                      Icons.visibility_off:Icons.visibility),onPressed: (){
                    setState(() {
                      isVisible1=!isVisible1;
                    });
                  },),
                );
              }),

              verticalSpace(50),
              Container(
                height: 43,
                decoration: Decorations.backGroundDecorationButton().copyWith(
                    borderRadius: BorderRadius.circular(40)
                ),
                child: CustomElevatedButton(
                  backgroundColor: Colors.transparent,
                  onTap: (){
                  },
                  buttonText:'تحديث',
                  width: MediaQuery.of(context).size.width*0.5,
                  height: 35,
                  fontSize: 17,
                  borderRadius: 40,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
