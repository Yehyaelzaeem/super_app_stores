import 'package:cogina_restaurants/core/helpers/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';
import '../../../../../../../core/translations/locale_keys.dart';

class ExtraItem extends StatelessWidget {
  final String extraName;
  final String extraPrice;
  const ExtraItem({super.key, required this.extraName, required this.extraPrice});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin:  EdgeInsets.symmetric(vertical: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.09),
          border: Border.all(color: backBlue2.withOpacity(0.1),width: 1,),
          borderRadius: BorderRadius.circular(10),
        ),
        child:
               Row(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(extraName,style: TextStyles.font18Black700Weight.copyWith(
                       fontSize: 12
                   ),),
                   horizontalSpace(40),
                   Text('$extraPrice ${LocaleKeys.currency.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                       color: backBlue2,
                       fontSize: 12

                   ),),
                 ],
               ),
      );


    //   Padding(
    //   padding:  EdgeInsets.only(top: 8.h),
    //   child:
    //
    //    Column(
    //      children: [
    //        Row(
    //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //          children: [
    //            Text(extraName,style: TextStyles.font18Black700Weight.copyWith(
    //                fontSize: 15
    //            ),),
    //            Text('$extraPrice ${LocaleKeys.currency.tr()}',style: TextStyles.font18Black700Weight.copyWith(
    //                color: backBlue2,
    //                fontSize: 15
    //
    //            ),),
    //            SizedBox(width: 10,)
    //          ],
    //        ),
    //        verticalSpace(5),
    //        Divider(color: backBlue2.withOpacity(0.1),height: 1,),
    //      ],
    //    )
    // );
  }
}
