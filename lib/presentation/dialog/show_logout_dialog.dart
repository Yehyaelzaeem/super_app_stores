
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/routing/routes.dart';
import '../../core/translations/locale_keys.dart';
import '../../domain/provider/local_auth_provider_cubit.dart';
import 'base/simple_dialogs.dart';

Future<bool?> showLogoutDialog(BuildContext context) async {

  return await showQuestionDialog(
    context,
    dialogType: DialogType.info,
    btnTextPositive: LocaleKeys.no.tr(),
    btnTextNegative: LocaleKeys.yes.tr(),
    question: LocaleKeys.logOut.tr(),
    desc:LocaleKeys.logOutMes.tr() ,
    // tr(LocaleKeys.wantToSignOut),
    onNegativeClick: () async{
      BlocProvider.of<LocalAuthCubit>(context, listen: false).logOut(context);
    },
    onPositiveClick: () {},
  );
}

Future<bool?> showDeleteAccountDialog(BuildContext context) async {

  return await showQuestionDialog(
    context,
    dialogType: DialogType.error,
    btnTextPositive: LocaleKeys.no.tr(),
    btnTextNegative: LocaleKeys.yes.tr(),
    question: LocaleKeys.deleteAccount.tr(),
    desc:LocaleKeys.deleteAccountMes.tr() ,
    // tr(LocaleKeys.wantToSignOut),
    onNegativeClick: () {
      BlocProvider.of<LocalAuthCubit>(context, listen: false).logOut(context);
    },
    onPositiveClick: () {},
  );
}


// _onLogoutPress(BuildContext context) {
//   BlocProvider.of<LocalAuthCubit>(context, listen: false).logOut().then((isLogOut) {
//     if (isLogOut) {
//       Navigator.pop(context);
//       NavigationService.pushNamedAndRemoveUntil(Routes.welcomeScreen);
//     }
//   });
