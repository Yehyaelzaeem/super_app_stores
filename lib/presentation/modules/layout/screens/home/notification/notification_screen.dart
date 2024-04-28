import 'package:cogina_restaurants/presentation/modules/layout/screens/home/notification/widgets/custom_notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: AppBar(

        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor:  whiteColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Notification',
          style: TextStyles.font20Black700Weight.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          CustomNotificationItem(),
          CustomNotificationItem(),
          CustomNotificationItem(),
          CustomNotificationItem(),
        ],
      ),
    );
  }
}
