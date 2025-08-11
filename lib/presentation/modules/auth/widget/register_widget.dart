import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/decoration.dart';
import '../../../../core/translations/locale_keys.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/custom_text_field.dart';
import '../auth_cubit.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit =AuthCubit.get(context);
    return
     SingleChildScrollView(
       child:  Column(
         children: [
           verticalSpace(35),
           CustomTextField(
               prefixIcon: const Icon(
                 Icons.person,
                 color: primaryColor,
               ),
               contentHorizontalPadding: 20,
               fillColor: backGroundGray,
               borderRadius: 40,
               validationFunc: (value) {
                 if (value == null || value.isEmpty) {
                   return LocaleKeys.firstNameEmpty.tr();
                 }
                 return null;
               },
               textInputAction: TextInputAction.next,
               borderColor: whiteColor.withOpacity(0.1),
               hintText: LocaleKeys.firstName.tr(),
               controller: cubit.regFirstNameController),
           verticalSpace(20),
           CustomTextField(
               prefixIcon: const Icon(
                 Icons.person,
                 color: primaryColor,
               ),
               contentHorizontalPadding: 20,
               fillColor: backGroundGray,
               borderRadius: 40,
               textInputAction: TextInputAction.next,
               validationFunc: (value) {
                 if (value == null || value.isEmpty) {
                   return LocaleKeys.lastNameEmpty.tr();
                 }
                 return null;
               },
               borderColor: whiteColor.withOpacity(0.1),
               hintText: LocaleKeys.lastName.tr(),
               controller: cubit.regLastNameController),
           verticalSpace(20),
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
             controller:cubit.regPhoneController,
             textInputAction: TextInputAction.next,
             // onFieldSubmitted: (vsl){
             //   cubit.otpCode(cubit.phoneController.text,context);
             // },
           ),
           verticalSpace(20),
           CustomTextField(
               textInputType: TextInputType.emailAddress,
               prefixIcon: const Icon(
                 Icons.email,
                 color: primaryColor,
               ),
               contentHorizontalPadding: 20,
               fillColor: backGroundGray,
               borderRadius: 40,
               textInputAction: TextInputAction.next,
               borderColor: whiteColor.withOpacity(0.1),
               hintText: LocaleKeys.email.tr(),
               controller: cubit.regEmailController),
           verticalSpace(20),
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
           //   controller: cubit.regPasswordController,
           //   textInputAction: TextInputAction.done,
           //   onFieldSubmitted: (vsl){
           //     // cubit.otpCode(cubit.phoneController.text,context);
           //     cubit.register(context) ;
           //   },
           // ),
           // verticalSpace(20),
           // CustomTextField(
           //   // textInputType: TextInputType.number,
           //   prefixIcon: const Icon(
           //     Icons.lock_open,
           //     color: primaryColor,
           //   ),
           //   fillColor: backGroundGray,
           //   borderRadius: 30,
           //   isPassword: true,
           //   borderColor: whiteColor.withOpacity(0.1),
           //   hintText: LocaleKeys.confirm.tr(),
           //   controller: cubit.confirmPasswordController,
           //   textInputAction: TextInputAction.done,
           //   onFieldSubmitted: (vsl){
           //     // cubit.otpCode(cubit.phoneController.text,context);
           //     cubit.register(context);
           //
           //   },
           // ),
           // verticalSpace(45),
           BlocConsumer<AuthCubit, AuthState>(
             listener: (context, state) {},
             builder: (context, state) {
               return Container(
                 decoration: Decorations.backGroundDecorationButton().copyWith(borderRadius: BorderRadius.circular(40)),
                 height: 47,
                 child: FittedBox(
                   fit: BoxFit.scaleDown,
                   child: CustomElevatedButton(
                     isLoading:state is RegisterLoadingState,
                     backgroundColor: Colors.transparent,
                     onTap: (){
                       cubit.register(context);

                     },
                     buttonText:LocaleKeys.log.tr(),
                     width: MediaQuery.of(context).size.width,
                     fontSize: 17,
                     borderRadius: 40,
                   ),
                 ),
               );
             },
           ),
           verticalSpace(150),

         ],
       ),
     );
  }
}
