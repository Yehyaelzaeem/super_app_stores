import 'package:cogina_restaurants/presentation/modules/orders/widgets/order_provider_item.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/resources/color.dart';
import '../../component/custom_app_bar.dart';
import '../../component/cutsom_calendar.dart';

class ProviderOrdersScreen extends StatelessWidget {
  const ProviderOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'الطلبات',
      ),
      body: SingleChildScrollView
        (
        child: Column(
          children: [
            const CustomCalender(),
            verticalSpace(20),
            OrderProviderItem(),
            verticalSpace(20),
            OrderProviderItem(),
            verticalSpace(20),
            OrderProviderItem(),
            verticalSpace(20),
            OrderProviderItem(),
          ],
        ),
      ),
    );
  }
}
