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
import '../../../../../../core/resources/styles.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/custom_elevated_button.dart';
import '../orders_cubit.dart';


class OrderItem extends StatelessWidget {
  final OrdersModelData ordersModelData;
  const OrderItem({super.key, required this.ordersModelData});

  @override
  Widget build(BuildContext context) {
    OrdersCubit cubit =OrdersCubit.get();
    return  Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 5)]
      ),
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpace(10),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImage(
                    height: 70,
                    width: 70,
                    image: ordersModelData.details?.data?[0].image??'',
                    radius: 50,
                  ),
                  horizontalSpace(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(ordersModelData.client?.name??'',style: TextStyles.font18Black700Weight,),
                      Row(
                        children: [
                          Text(ordersModelData.client?.address??'',style: TextStyles.font15CustomGray400Weight,),
                          const Icon(Icons.location_on,color: Colors.grey,),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          context.pushNamed(
                            Routes.orderDetailsScreen,arguments: {'ordersModelData':ordersModelData}
                          );
                        },
                        child: Row(
                          children: [
                            Text(LocaleKeys.orderDetails.tr(),style: TextStyles.font15CustomGray400Weight.copyWith(
                                color: backBlue2
                            ),),
                            const Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey,size: 18,),
                          ],
                        ),
                      )
                    ],),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${ordersModelData.orderTotal??''} ${LocaleKeys.lyd.tr()}',style: TextStyles.font18Black700Weight,),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: redColor.withOpacity(0.3),
                            radius: 18,
                            child:
                            const Icon(Icons.phone,
                              color: redColor,),
                          ),
                          horizontalSpace(10),
                          CircleAvatar(
                            backgroundColor: backBlue2.withOpacity(0.3),
                            radius: 18,
                            child:
                            const Icon(Icons.message_outlined,
                                color: backBlue2),
                          ),
                          horizontalSpace(10),
                          CircleAvatar(
                            backgroundColor: Colors.blue.withOpacity(0.3),

                            radius: 18,
                            child:
                            const Icon(Icons.send,
                                color:  Colors.blue),
                          )
                        ],
                      )
                    ],),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  horizontalSpace(10),
                  Container(
                    decoration: Decorations.backGroundDecorationButton().copyWith(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: CustomElevatedButton(
                      backgroundColor: Colors.transparent,
                      onTap: (){
                        cubit.acceptOrder(orderId: ordersModelData.id!);
                      },
                      buttonText:LocaleKeys.agree.tr(),
                      width: MediaQuery.of(context).size.width*0.4,
                      height: 30,
                      fontSize: 17,
                      borderRadius: 40,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: CustomElevatedButton(
                      backgroundColor: Colors.transparent,
                      onTap: (){
                        cubit.rejectOrder(orderId: ordersModelData.id!);
                      },
                      buttonText:LocaleKeys.reject.tr(),
                      width: MediaQuery.of(context).size.width*0.4,
                      height: 30,
                      fontColor:  Colors.grey,
                      fontSize: 17,
                      borderRadius: 40,
                    ),
                  ),
                  horizontalSpace(10),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
