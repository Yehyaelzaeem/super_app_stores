import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/images/custom_image.dart';
import '../../home/widgets/custom_chip.dart';


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
                    height: 120.h,
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
                                height: 1,
                              fontSize: 13
                            ),),
                          ),
                          horizontalSpace(10),
                          Text('${ordersDetailsData.productPrice} ${LocaleKeys.currency.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                              fontSize: 13,
                              color: redColor),),
                          horizontalSpace(10)
                        ],
                      ),
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             verticalSpace(4),
                             Row(
                               children: [
                                 Text("${LocaleKeys.qty.tr()}  :" ,style: TextStyles.font18Black700Weight.copyWith(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 13.sp,
                                 ),),
                                 horizontalSpace(10),
                                 Text('${ordersDetailsData.qty}',style: TextStyles.font18Black700Weight.copyWith(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 13.sp,
                                     color: redColor
                                 ),),
                               ],
                             ),
                             verticalSpace(4),
                             if(ordersDetailsData.size!=null)
                             Row(
                               children: [
                                 Text("${LocaleKeys.size.tr()}  :" ,style: TextStyles.font18Black700Weight.copyWith(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 11.sp,
                                 ),),
                                 horizontalSpace(10),
                                 Text('${ordersDetailsData.size?.name??''}',style: TextStyles.font18Black700Weight.copyWith(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 11.sp,
                                     color: redColor
                                 ),),
                               ],
                             ),
                             ordersDetailsData.addition?.data!=null&&ordersDetailsData.addition!.data!.isNotEmpty?
                             FittedBox(
                               child: SizedBox(
                                 height: 30,
                                 width: MediaQuery.of(context).size.width*0.5,
                                 child: SingleChildScrollView(
                                   scrollDirection: Axis.horizontal,
                                   child: Row(
                                     children: [
                                       Wrap(
                                           spacing: 5,
                                           children: [
                                             ...ordersDetailsData.addition?.data?.map((e) =>
                                                 SizedBox(
                                                   height: 30.h,
                                                   child: FittedBox(
                                                     child: OutlinedChip(
                                                       backgroundColor: sandwichBackGround,
                                                       avatarBackgroundColor: primaryColor,
                                                       label: e.name??'',
                                                       price: '${e.price}',
                                                     ),
                                                   ),
                                                 ),)??[]
                                           ]),
                                     ],
                                   ),
                                 ),
                               ),
                             ):const SizedBox.shrink(),
                             verticalSpace(5),

                             Text('${ordersDetailsData.productPrice} ${LocaleKeys.currency.tr()}',style: TextStyles.font18Black700Weight.copyWith(
                                 fontWeight: FontWeight.w500,
                                 fontSize: 13.sp
                             ),),
                           ],
                         ),
                         verticalSpace(8),

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
