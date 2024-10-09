import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/component/images/custom_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/resources/decoration.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/fonts/app_fonts.dart';
import '../../../../../../core/resources/styles.dart';
import '../../../../../../core/utils/contact_helper.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../../../../../primary_button.dart';
import '../orders_cubit.dart';

class OrderItem extends StatelessWidget {
  final OrdersModelData ordersModelData;

  const OrderItem({super.key, required this.ordersModelData});

  @override
  Widget build(BuildContext context) {
    OrdersCubit cubit = OrdersCubit.get();
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 5,
          offset: Offset(1, 3),
          )]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpace(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        CustomImage(
                          height: 100.h,
                          width: 80.w,
                          image: ordersModelData.details?.data?[0].image ?? '',
                          radius: 10,
                        ),
                        horizontalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //ordersModelData.client?.name ?? ''
                          Container(
                            width :100.w,
                            child:  Text(
                              ordersModelData.client?.name ?? '',
                              style: TextStyles.font18Black700Weight.copyWith(height: 1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                            ),
                          ),
                            Row(
                              children: [
                                Text(
                                  ordersModelData.client?.address ?? '',
                                  style: TextStyles.font15CustomGray400Weight,
                                ),
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                context.pushNamed(Routes.orderDetailsScreen,
                                    arguments: {
                                      'ordersModelData': ordersModelData
                                    });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    LocaleKeys.orderDetails.tr(),
                                    style: TextStyles.font15CustomGray400Weight
                                        .copyWith(color: backBlue2),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${ordersModelData.orderTotal ?? ''} ${LocaleKeys.currency.tr()}',
                        style: TextStyles.font18Black700Weight,
                      ),
                      verticalSpace(20),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                ContactHelper.launchCall(ordersModelData.client?.phone ?? '');
                              },
                              child: CircleAvatar(
                                backgroundColor: redColor.withOpacity(0.3),
                                radius: 18,
                                child: const Icon(
                                  Icons.phone,
                                  color: redColor,
                                ),
                              ),

                            ),
                            horizontalSpace(10),
                            InkWell(
                              onTap: () {
                                ContactHelper.openWhatsApp1(context,ordersModelData.client?.phone ?? '');
                              },
                              child:  CircleAvatar(
                                backgroundColor: backBlue2.withOpacity(0.3),
                                radius: 18,
                                child: Icon(Icons.message_outlined,
                                    color: backBlue2),
                              ),),
                            horizontalSpace(10),
                            InkWell(
                                onTap: () {
                                  ContactHelper.launchMap(lat: double.parse(ordersModelData.client?.location?.lng ??'0.0'), long: double.parse(ordersModelData.client?.location?.lng ??'0.0'));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(0.3),
                                  radius: 18,
                                  child: const Icon(Icons.location_on_outlined, color: Colors.blue),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          verticalSpace(10),

          if (ordersModelData.status == 'padding') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 40,
                  onTap: () {
                    cubit.acceptOrder(orderId: ordersModelData.id!);
                  }, text: LocaleKeys.agree.tr(),),
                PrimaryButtonWidget(
                    color: Colors.grey.shade200,
                    fontColor: Colors.grey.shade700,
                    borderColor: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width * 0.35,
                    onTap: () {
                      cubit.rejectOrder(orderId: ordersModelData.id!);

                    }, height: 40,
                    text: LocaleKeys.reject.tr()),
              ],
            ),
            verticalSpace(10)
          ],
          if (ordersModelData.status == 'restaurant_accepted') ...[
            PrimaryButtonWidget(
                onTap: () {
                  cubit.inProgressOrder(orderId: ordersModelData.id??0);
            }, text: 'بدأ التحضير'),
          ],
          if (ordersModelData.status == 'restaurant_order_progress') ...[
            PrimaryButtonWidget(
                onTap: () {
                  cubit.finishOrder(orderId: ordersModelData.id??0);
            }, text: 'إنهاء الطلب'),
          ],
          if (ordersModelData.status == 'restaurant_done') ...[
            PrimaryButtonWidget(
                onTap: () {
                  cubit.deliveredOrder(orderId: ordersModelData.id??0);
            }, text: 'تسليم الطلب'),

          ],
          if (ordersModelData.status == 'restaurant_delivered_driver' || ordersModelData.status == 'restaurant_rejected')
            verticalSpace(10),
        ],
      ),
    );
  }
}
