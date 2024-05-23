import 'package:flutter/material.dart';

import '../../core/resources/color.dart';
import '../../core/resources/fonts/app_fonts.dart';
import '../../core/resources/styles.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('LOGO',style: TextStyles.font20Black700Weight.copyWith(
        fontFamily: AppFonts.lateefFont,
        color: primaryColor,
        fontSize: 50
    ),));
  }

}
