import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/decoration.dart';
import '../../../../core/translations/locale_keys.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/custom_text_field.dart';
import '../auth_cubit.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit =AuthCubit.get(context);
    if(kDebugMode){
      cubit.phoneController.text=  '01027362575';
      cubit.passwordController.text=  '123456';
    }
    return  SingleChildScrollView(
      child:  Column(
        children: [
          verticalSpace(35),
          CustomTextField(
            textInputType: TextInputType.number,
            prefixIcon: const Icon(
              Icons.phone,
              color: primaryColor,
            ),
            fillColor: backGroundGray,
            borderRadius: 30,
            borderColor: whiteColor.withOpacity(0.1),
            hintText: LocaleKeys.phone.tr(),
            controller:cubit.phoneController,
            textInputAction: TextInputAction.next,
            // onFieldSubmitted: (vsl){
            //   cubit.otpCode(cubit.phoneController.text,context);
            // },
          ),
          // verticalSpace(20),
          // CustomTextField(
          //   prefixIcon: const Icon(
          //     Icons.lock_open,
          //     color: primaryColor,
          //   ),
          //   isPassword: true,
          //   fillColor: backGroundGray,
          //   borderRadius: 30,
          //   borderColor: whiteColor.withOpacity(0.1),
          //   hintText: 'password2'.tr(),
          //   controller: cubit.passwordController,
          //   textInputAction: TextInputAction.done,
          //   onFieldSubmitted: (vsl){
          //     // cubit.otpCode(cubit.phoneController.text,context);
          //     cubit.login(cubit.phoneController.text, cubit.passwordController.text,context);
          //   },
          // ),
          verticalSpace(20),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                decoration: Decorations.backGroundDecorationButton().copyWith(borderRadius: BorderRadius.circular(40)),
                height: 47,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomElevatedButton(
                    isLoading:state is LoginLoadingState,
                    backgroundColor: Colors.transparent,
                    onTap: (){
                      cubit.login(cubit.phoneController.text, cubit.passwordController.text, context);
                      // if(type=='login'){
                      //   cubit.otpCode( phone: cubit.phoneController.text, context: context);
                      // }else{
                      //   cubit.register(context);
                      // }
                    },
                    buttonText:LocaleKeys.log.tr(),
                    width: MediaQuery.of(context).size.width,
                    fontSize: 17,
                    borderRadius: 40,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );

  }
}
