import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/orders/order_details/widgets/order_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../core/utils/contact_helper.dart';
import '../../../../../../core/utils/globals.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/custom_divider.dart';
import '../invoice/invoice_pdf.dart';
import '../widgets/custom_order_details_item.dart';
import '../widgets/custom_row details.dart';
import '../widgets/custom_text_row_cart.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrdersModelData ordersModelData;

  const OrderDetailsScreen({super.key, required this.ordersModelData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.orderNo.tr()} ${ordersModelData.id}',
                    style: TextStyles.font20Black700Weight
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: (){
                      generateAndPrintInvoice(ordersModelData: ordersModelData);
                    },
                    child:Icon(Icons.print,color: Colors.grey,),)
                ],
              ),
              Text(
                '${ordersModelData.date}',
                style: TextStyles.font16Black500Weight,
              ),
              verticalSpace(10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderDetailsWidget(
                        title: LocaleKeys.shippingAddress.tr(),
                        text: ordersModelData.client?.address ?? '',
                        onTap: () {
                          ContactHelper.launchMap(
                              lat: double.parse(
                                  ordersModelData.client?.location?.lng ??
                                      '0.0'),
                              long: double.parse(
                                  ordersModelData.client?.location?.lng ??
                                      '0.0'));
                        },
                      ),
                      verticalSpace(15),
                      OrderDetailsWidget(
                        icon: Icons.phone,
                        title: LocaleKeys.phoneNumber.tr(),
                        text: ordersModelData.client?.phone ?? '',
                        onTap: () {
                          ContactHelper.launchCall(
                              ordersModelData.client?.phone ?? '');
                        },
                      ),
                      verticalSpace(15),
                      OrderDetailsWidget(
                        icon: Icons.payment,
                        title: LocaleKeys.paymentMethod.tr(),
                        text: ordersModelData.paymentMethod ?? '',
                        onTap: () {},
                      ),
                      verticalSpace(15),
                      if (ordersModelData.note != null)
                        OrderDetailsWidget(
                          icon: Icons.note,
                          title: LocaleKeys.note.tr(),
                          text: ordersModelData.note ?? '',
                          onTap: () {},
                        ),
                      verticalSpace(15),
                    ],
                  ),
                ),
              ),
              if(ordersModelData.orderType=='prescription')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${LocaleKeys.prescription.tr()} :-',style: TextStyles.font16Black600Weight,),
                    CustomImage(image: ordersModelData.prescriptionsModel?.image??'',
                      radius: 10,
                      openImage: true,
                      height: 300.h,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ],
                )
                else
              ...ordersModelData.details!.data!
                  .map((e) => CustomOrderDetailsItemWidget(
                        ordersDetailsData: e,
                      )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    Text(
                      LocaleKeys.orderSummary.tr(),
                      style: TextStyles.font20Black700Weight.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    verticalSpace(10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor),
                      child: Column(
                        children: [
                          CustomTextRowCartWidget(
                            title: LocaleKeys.subtotal.tr(),
                            text: '${ordersModelData.orderPrice} ${LocaleKeys.currency.tr()}',
                            vertical: 7.h,
                          ),
                          CustomTextRowCartWidget(
                            title: LocaleKeys.discount.tr(),
                            text: '${ordersModelData.discout} ${LocaleKeys.currency.tr()}',
                            vertical: 7.h,
                          ),
                          CustomTextRowCartWidget(
                            title: LocaleKeys.shipping.tr(),
                            text: '${ordersModelData.deliveryFees} ${LocaleKeys.currency.tr()}',
                            vertical: 7.h,
                          ),
                          CustomTextRowCartWidget(
                            title: LocaleKeys.total.tr(),
                            text: '${ordersModelData.orderTotal} ${LocaleKeys.currency.tr()}',
                            vertical: 7.h,
                          ),

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
    ));
  }
}
