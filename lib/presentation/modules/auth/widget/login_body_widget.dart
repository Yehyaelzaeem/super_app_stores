import 'package:cogina_restaurants/presentation/modules/auth/widget/register_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/decoration.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/translations/locale_keys.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/custom_text_field.dart';
import '../../../component/inputs/phone_country/custom_text_field_phone_code.dart';
import '../auth_cubit.dart';
import 'login_widget.dart';

class AuthBodyWidget extends StatelessWidget {
  const AuthBodyWidget({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit =AuthCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          type=='register'?
          RegisterWidget():LoginWidget(),
          // verticalSpace(20),
          // Text(
          //   LocaleKeys.enterPhone.tr(),
          //   style: TextStyles.font18Black700Weight
          //       .copyWith(fontWeight: FontWeight.bold),
          // ),
          // verticalSpace(10),
          // CustomTextFieldPhoneCode(
          //   label: LocaleKeys.phone.tr(),
          //   initialCountryCode:'EG',
          //   controller:type=='login'?cubit.phoneController: cubit.regPhoneController,
          //   autofocus: false,
          //   textInputAction: TextInputAction.next,
          //   onCountryChanged: (v){
          //
          //   },
          // ),
          // if(type=='login')
          //   verticalSpace(25),
          // CustomTextField(
          //   textInputType: TextInputType.number,
          //   prefixIcon: const Icon(
          //     Icons.phone,
          //     color: primaryColor,
          //   ),
          //   fillColor: backGroundGray,
          //   borderRadius: 30,
          //   borderColor: whiteColor.withOpacity(0.1),
          //   hintText: LocaleKeys.phone.tr(),
          //   controller:type=='login'?cubit.phoneController: cubit.regPhoneController,
          //   textInputAction: TextInputAction.next,
          //   // onFieldSubmitted: (vsl){
          //   //   cubit.otpCode(cubit.phoneController.text,context);
          //   // },
          // ),
          // verticalSpace(20),
          // CustomTextField(
          //   // textInputType: TextInputType.number,
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
          //
          //   },
          // ),
          if(type=='register')...[
            verticalSpace(20),
            CustomTextField(
              // textInputType: TextInputType.number,
              prefixIcon: const Icon(
                Icons.lock_open,
                color: primaryColor,
              ),
              fillColor: backGroundGray,
              borderRadius: 30,
              isPassword: true,
              borderColor: whiteColor.withOpacity(0.1),
              hintText: LocaleKeys.confirm.tr(),
              controller: cubit.confirmPasswordController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (vsl){
                // cubit.otpCode(cubit.phoneController.text,context);
                cubit.login(cubit.phoneController.text, cubit.passwordController.text,context);

              },
            ),],
          // verticalSpace(45),
          // BlocConsumer<AuthCubit, AuthState>(
          //         listener: (context, state) {},
          //         builder: (context, state) {
          //           return Container(
          //                 decoration: Decorations.backGroundDecorationButton().copyWith(borderRadius: BorderRadius.circular(40)),
          //                 height: 47,
          //                 child: FittedBox(
          //                   fit: BoxFit.scaleDown,
          //                   child: CustomElevatedButton(
          //                     isLoading:type=='login'? state is OtpLoadingState:state is RegisterLoadingState,
          //                     backgroundColor: Colors.transparent,
          //                     onTap: (){
          //                       if(type=='login'){
          //                         cubit.otpCode( phone: cubit.phoneController.text, context: context);
          //                       }else{
          //                         cubit.register(context);
          //                       }
          //                     },
          //                     buttonText: type=='login'?LocaleKeys.log.tr():LocaleKeys.next.tr(),
          //                     width: MediaQuery.of(context).size.width,
          //                     fontSize: 17,
          //                     borderRadius: 40,
          //                   ),
          //                 ),
          //               );
          //         },
          //       )
        ],
      ),
    );
  }
}
