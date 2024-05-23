import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/images/custom_image.dart';


class CustomOrderDetailsItemWidget extends StatelessWidget {
  final OrdersDetailsData ordersDetailsData;
  const CustomOrderDetailsItemWidget({super.key, required this.ordersDetailsData});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black38,blurRadius: 3)]
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width:120.w,
                    height: 100.h,
                    child: CustomImage(image: ordersDetailsData.image??'',radius: 5,)),
                horizontalSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(ordersDetailsData.productName??'',style: TextStyles.font18Black700Weight.copyWith(
                                height: 1
                            ),),
                          ),
                          horizontalSpace(10),
                          Text('${ordersDetailsData.productPrice} ${LocaleKeys.lyd.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                              color: redColor),),
                          horizontalSpace(10)
                        ],
                      ),
                     Row(
                       children: [
                         Column(
                           children: [
                             verticalSpace(4),
                             Text('${ordersDetailsData.qty}',style: TextStyles.font18Black700Weight.copyWith(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 12.sp,
                                 color: redColor
                             ),),
                             Text('${ordersDetailsData.productPrice} ${LocaleKeys.lyd.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                                 fontWeight: FontWeight.w500,
                                 fontSize: 12.sp
                             ),),
                           ],
                         ),
                         horizontalSpace(8),

                       ],
                     )
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
