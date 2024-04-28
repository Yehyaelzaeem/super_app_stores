import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_cubit.dart';
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
      appBar:  const CustomAppBar(
        color: backGroundGray,
        title: 'تفاصيل البنك',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.bankKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('اسم صاحب الحساب المصرقي',
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The holder name is empty';
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
                Text('اسم البنك',
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The name is empty';
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
                Text('رقم الحساب',
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The number is empty';
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
                Text('اسم الفرع',
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The branch name is empty';
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
                Text('ايبان',
                  style: TextStyles.font18Black700Weight.copyWith(
                      color: Colors.grey.shade700
                  ),
                ),
                verticalSpace(7),
                CustomTextField(
                  validationFunc: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The ipan is empty';
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
                                        buttonText:(profileCubit.profileModel!.bankAccount!=null&&profileCubit.profileModel!.bankAccount!.holderName!=null)?'تحديث':'تم',
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
