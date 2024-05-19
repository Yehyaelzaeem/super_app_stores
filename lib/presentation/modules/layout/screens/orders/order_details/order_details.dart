import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/translations/locale_keys.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../../../../component/custom_divider.dart';
import '../widgets/custom_row details.dart';


class OrderDetailsScreen extends StatelessWidget {
  final OrdersDetails ordersDetails;
  const OrderDetailsScreen({super.key, required this.ordersDetails});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
         SingleChildScrollView(
        child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Row(
                 children: [

                 ],
               ),
                const CustomDivider(),
                CustomDivider(),

              ],
            )
        ),
      ),

        ],
      )
    );
  }
}
