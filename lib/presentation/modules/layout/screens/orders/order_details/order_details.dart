import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../core/utils/contact_helper.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/custom_divider.dart';
import '../widgets/custom_order_details_item.dart';
import '../widgets/custom_row details.dart';
import '../widgets/custom_text_row_cart.dart';


class OrderDetailsScreen extends StatelessWidget {
  final OrdersModelData ordersModelData;
  const OrderDetailsScreen({super.key, required this.ordersModelData});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    verticalSpace(50),
                  Text('${LocaleKeys.orderNo.tr()} ${ordersModelData.id}',style: TextStyles.font20Black700Weight.copyWith(
                      fontWeight: FontWeight.bold
                  ),),
                  Text('${ordersModelData.date}',style: TextStyles.font16Black500Weight,),
                  verticalSpace(10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                      child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                     Text(' ${LocaleKeys.shippingAddress.tr()}',style: TextStyles.font20Black700Weight.copyWith(
                         fontWeight: FontWeight.bold,
                         fontSize: 16.sp
                     ),),
                         verticalSpace(5),
                               Row(
                                 children: [
                                   Text(
                                     ordersModelData.client?.address ?? '',
                                     style: TextStyles.font20Black700Weight.copyWith(
                                         fontWeight: FontWeight.w600,
                                         color: customGray,
                                         fontSize: 16.sp),),
                                   horizontalSpace(25),
                                   InkWell(
                                       onTap: () {
                                         ContactHelper.launchMap(lat: double.parse(ordersModelData.client?.location?.lng ??'0.0'), long: double.parse(ordersModelData.client?.location?.lng ??'0.0'));
                                       },
                                       child: CircleAvatar(
                                         radius: 15,
                                         child: Icon(Icons.location_on,color: primaryColor,size: 14.sp,),
                                       )

                                   ),
                                 ],
                               ),
                         verticalSpace(5),
                         Text(' ${LocaleKeys.phoneNumber.tr()}',style: TextStyles.font20Black700Weight.copyWith(
                 fontWeight: FontWeight.bold,
                 fontSize: 16.sp
                         ),),
                         verticalSpace(5),
                               Row(
                                 children: [
                                   Text(
                                     ordersModelData.client?.phone ?? '',
                                     style: TextStyles.font20Black700Weight.copyWith(
                                         fontWeight: FontWeight.w600,
                                         color: customGray,
                                         fontSize: 16.sp),),
                                   horizontalSpace(25),
                                   InkWell(
                                       onTap: () {
                                         ContactHelper.launchCall(ordersModelData.client?.phone ?? '');
                                       },
                                       child: CircleAvatar(
                                         radius: 15,
                                         child: Icon(Icons.phone,color: primaryColor,size: 12.sp,),
                                       )

                                   ),
                                 ],
                               ),
                verticalSpace(5),
                Text(' ${LocaleKeys.paymentMethod.tr()}',style: TextStyles.font20Black700Weight.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp
                ),),
                verticalSpace(5),
                Text(ordersModelData.paymentMethod??'',style: TextStyles.font20Black700Weight.copyWith(
                    fontWeight: FontWeight.w600,
                    color: customGray,
                    fontSize: 12.sp
                ),),
                verticalSpace(20),
                               if(ordersModelData.note!=null)
                                 ...[
                                   Text(
                                     ' ${LocaleKeys.note.tr()}',
                                     style: TextStyles.font20Black700Weight.copyWith(
                                         fontWeight: FontWeight.bold, fontSize: 16.sp),
                                   ),
                                   verticalSpace(5),
                                   Text(
                                     ordersModelData.note ?? '',
                                     style: TextStyles.font20Black700Weight.copyWith(
                                         fontWeight: FontWeight.w600,
                                         color: customGray,
                                         fontSize: 12.sp),
                                   ),
                                 ],
                       ],
                      ),
                    ),
                  ),
                 ...ordersModelData.details!.data!.map((e) =>  CustomOrderDetailsItemWidget(ordersDetailsData: e,)),
                          Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          verticalSpace(10),
                          Text(LocaleKeys.orderSummary.tr(),style: TextStyles.font20Black700Weight.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                          ),),
                          verticalSpace(10),

                          Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor
                          ),
                          child:
                          Column(
                          children: [
                          CustomTextRowCartWidget(title: LocaleKeys.subtotal.tr(), text: '${ordersModelData.orderPrice} ${LocaleKeys.currency.tr()}',vertical: 7.h,),
                          CustomTextRowCartWidget(title: LocaleKeys.discount.tr(), text: '${ordersModelData.discout} ${LocaleKeys.currency.tr()}',vertical: 7.h,),
                          CustomTextRowCartWidget(title: LocaleKeys.shipping.tr(), text: '${ordersModelData.deliveryFees} ${LocaleKeys.currency.tr()}',vertical: 7.h,),
                          CustomTextRowCartWidget(title: LocaleKeys.total.tr(), text: '${ordersModelData.orderTotal} ${LocaleKeys.currency.tr()}',vertical: 7.h,),
                          verticalSpace(50),
                          ],
                          ),
                          ),

                          ],
                          ),
                          )

                          ],
                          ),
              ),
            ),
          )
    );
  }
}
// /  CustomDivider(),