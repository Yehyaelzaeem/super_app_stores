import 'package:cogina_restaurants/presentation/modules/layout/screens/restaurant/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../component/custom_app_bar.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  bool switchValue =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      CustomAppBar(
        title: 'متاح الان',
        isBackButtonExist: false,
        actions:[
          Switch(
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
          ),
          SizedBox(width: 17.w,),
        ]

      ),
      body:   Container(
        color: customWhite,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(20),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text('طلبات المطعم',
                    style: TextStyles.font20Black700Weight.copyWith(
                        color: backBlue2,
                        fontSize: 18
                    ),
                  ),
                ),
                verticalSpace(20),
                const OrderItem(),
                verticalSpace(20),
                const OrderItem(),
                verticalSpace(20),
                const  OrderItem(),
              ],
            ),
          ),
        ),
      )
    );
  }
}
