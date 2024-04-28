
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import '../../core/routing/routes.dart';
import 'base/simple_dialogs.dart';

Future<bool?> showLogoutDialog(BuildContext context) async {

  return await showQuestionDialog(
    context,
    dialogType: DialogType.info,
    btnTextPositive: 'No',
    btnTextNegative: 'Yes',
    question: 'Log Out',
    desc:'Are you sure you want to Log out?' ,
    // tr(LocaleKeys.wantToSignOut),
    onNegativeClick: () {
      context.pushReplacementNamed(Routes.chooseUserScreen);
      // _onLogoutPress(context)
    },
    onPositiveClick: () {},
  );
}

Future<bool?> showDeleteAccountDialog(BuildContext context) async {

  return await showQuestionDialog(
    context,
    dialogType: DialogType.error,
    btnTextPositive: 'No',
    btnTextNegative: 'Yes',
    question: 'Delete Account',
    desc:'Are you sure you want to Delete Account?' ,
    // tr(LocaleKeys.wantToSignOut),
    onNegativeClick: () {
      context.pushReplacementNamed(Routes.chooseUserScreen);
      // _onLogoutPress(context)
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
