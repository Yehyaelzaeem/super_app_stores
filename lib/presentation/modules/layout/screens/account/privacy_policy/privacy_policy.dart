import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../component/custom_app_bar.dart';
import '../../../../../component/custom_app_contant_data.dart';
import '../../../../../component/custom_loading_widget.dart';
import '../account_cubit.dart';



class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountCubit cubit =AccountCubit.get(context);
    cubit.getPrivacy();
    return  Scaffold(
        appBar:  CustomAppBar(
          title: LocaleKeys.privacyPolicy.tr(),
        ),
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            if(state is GetDataSuccessState)
            {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child:  CustomAppContData(
                    image: '',
                    des: state.data.toString(), title: '',
                  ));
            }
            else{
              return const CustomLoadingWidget();
            }
          },
        )
    );
  }
}
