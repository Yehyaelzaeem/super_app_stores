import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/decoration.dart';
import '../../../../core/resources/styles.dart';
import '../../../component/custom_elevated_button.dart';
import '../../../component/custom_text_field.dart';
import '../../../component/inputs/phone_country/custom_text_field_phone_code.dart';
import '../auth_cubit.dart';

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              Text(
              LocaleKeys.enterFirstName.tr(),
              style: TextStyles.font18Black700Weight
                  .copyWith(fontWeight: FontWeight.bold),
            ),
             verticalSpace(10),
             CustomTextField(
                contentHorizontalPadding: 20,
                borderRadius: 40,
                validationFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.requiredField.tr();
                  }
                  return null;
                },
                // borderColor: AppColors.whiteColor.withOpacity(0.1),
                hintText: LocaleKeys.firstName.tr(),
                controller: cubit.regFirstNameController),
             verticalSpace(20),
              Text(
                LocaleKeys.enterLastName.tr(),
                style: TextStyles.font18Black700Weight
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              verticalSpace(10),
              CustomTextField(
                contentHorizontalPadding: 20,
                // fillColor: AppColors.backGroundGray,
                borderRadius: 40,
                validationFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.requiredField.tr();
                  }
                  return null;
                },
                // borderColor: AppColors.whiteColor.withOpacity(0.1),
                hintText: LocaleKeys.lastName.tr(),
                controller: cubit.regLastNameController),
          ],):const SizedBox.shrink(),
          verticalSpace(20),
          Text(
            LocaleKeys.enterPhone.tr(),
            style: TextStyles.font18Black700Weight
                .copyWith(fontWeight: FontWeight.bold),
          ),
          verticalSpace(10),
          CustomTextFieldPhoneCode(
            label: LocaleKeys.phone.tr(),
            initialCountryCode:'EG',
            controller:type=='login'?cubit.phoneController: cubit.regPhoneController,
            autofocus: false,
            textInputAction: TextInputAction.next,
            onCountryChanged: (v){

            },
          ),
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
                              isLoading:type=='login'? state is OtpLoadingState:state is RegisterLoadingState,
                              backgroundColor: Colors.transparent,
                              onTap: (){
                                if(type=='login'){
                                  cubit.otpCode( phone: cubit.phoneController.text, context: context);
                                }else{
                                  cubit.register(context);
                                }
                              },
                              buttonText: type=='login'?LocaleKeys.log.tr():LocaleKeys.next.tr(),
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
