import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../../../../../component/custom_text_field.dart';
import '../edit_profile/profile_cubit.dart';


class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountCubit cubit =AccountCubit.get(context);
    ProfileCubit profileCubit =ProfileCubit.get(context);
    if(profileCubit.profileModel!.bankAccount!=null&&profileCubit.profileModel!.bankAccount!.holderName!=null){
      cubit.passAccountData(context);
    }
    return Scaffold(
      backgroundColor:  backGroundGray,
      appBar:   CustomAppBar(
        color: backGroundGray,
        title: LocaleKeys.bankDetails.tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.bankKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.bankHolderName.tr(),
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
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
                  controller: cubit.holderName,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                ),
                verticalSpace(10),
                Text(LocaleKeys.bankName.tr(),
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
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
                  controller:cubit.bankName,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                ),
                verticalSpace(10),
                Text(LocaleKeys.accountNumber.tr(),
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  textInputType: TextInputType.number,
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
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
                  controller: cubit.accountNumber,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                ),
                verticalSpace(10),
                Text(LocaleKeys.branchName.tr(),
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
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
                  controller: cubit.branchName,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                ),
                verticalSpace(10),
                Text(LocaleKeys.iban.tr(),
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.requiredField.tr();
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
                  controller: cubit.iban,
                  borderRadius: 40,
                  borderColor: Colors.grey.shade400,
                ),
                verticalSpace(50),
                BlocConsumer<AccountCubit, AccountState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Center(
                                    child: Container(
                                      decoration: Decorations.backGroundDecorationButton().copyWith(
                                          borderRadius: BorderRadius.circular(40)
                                      ),
                                      child: CustomElevatedButton(
                                        isLoading: state is BankAccountLoadingState,
                                        backgroundColor: Colors.transparent,
                                        onTap: (){
                                          cubit.bankAccount(context);
                                        },
                                        buttonText:(profileCubit.profileModel!.bankAccount!=null&&profileCubit.profileModel!.bankAccount!.holderName!=null)?
                                        LocaleKeys.update.tr():
                                        LocaleKeys.done.tr(),
                                        width: MediaQuery.of(context).size.width*0.5,
                                        height: 40,
                                        fontSize: 17,
                                        borderRadius: 40,
                                      ),
                                    ),
                                  );
                      },
                    ),
                verticalSpace(35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
