import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';

class ExtraItem extends StatelessWidget {
  final String extraName;
  final String extraPrice;
  const ExtraItem({super.key, required this.extraName, required this.extraPrice});

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding:  EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(extraName,style: TextStyles.font18Black700Weight.copyWith(
              fontSize: 15
          ),),
          Text('$extraPrice LYD',style: TextStyles.font18Black700Weight.copyWith(
              color: backBlue2,
              fontSize: 15

          ),),
        ],
      ),
    );
  }
}
