import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatelessWidget {
  final void Function(bool) onToggle;
  final bool value;
  final String? title;
  final TextStyle? style;

  const CustomSwitch(
      {Key? key,
      required this.onToggle,
      required this.value ,
      this.title,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActive = value;
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatefulBuilder(builder: (context, setState) {
            return FlutterSwitch(
              width: 35,
              height: 20,
              padding: 5,
              toggleSize: 15,
              value: isActive,
              activeColor: customGreen,
              activeToggleColor: backgroundColor,
              inactiveColor:dividerColor,
              inactiveToggleColor: cardColor,
              onToggle: (value) {
                isActive = value;
                setState(() {
                  onToggle(!isActive);
                });
              },
            );
          }),
        ],
      ),
    );
  }
}
