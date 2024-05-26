import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/account_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../auth/widget/complete_data.dart';

class UpdateRestaurant extends StatelessWidget {
  const UpdateRestaurant({super.key}) ;

  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit =AccountCubit.get(context);
    accountCubit.pushToUpdateRestaurant(context);
    return   Scaffold(
      body: CompeteDataWidget(
        title: LocaleKeys.updateData.tr(),
        image: ProfileCubit.get(context).profileModel?.store?.files?.banner??'',
      ),
    );
  }
}
