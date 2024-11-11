
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/color.dart';
import '../../../core/resources/styles.dart';


class TextSwitch extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool? value;
  final void Function(bool) onToggle;

  TextSwitch({super.key, required this.text, this.fontSize, required this.onToggle, this.value=false});

  @override
  Widget build(BuildContext context) {
    bool isActive = value!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
          style: TextStyles.font18Black700Weight.copyWith(
              fontSize: 18,
              color: Colors.grey.shade800
          ),),
        CupertinoSwitch(
          value: isActive,
          activeColor: primaryColor,
          trackColor: Color(0xff9098A1),
          onChanged: (value) {
            isActive = value;
            onToggle(isActive);
          },
        )
      ],
    );
  }
}
