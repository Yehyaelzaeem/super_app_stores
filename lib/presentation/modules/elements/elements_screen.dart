
import 'package:cogina_restaurants/presentation/modules/elements/widgets/custom_element_item.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/resources/color.dart';
import '../../component/custom_app_bar.dart';

class ElementsScreen extends StatelessWidget {
  const ElementsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'العناصر',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomElementsItem(),
            verticalSpace(20),
            CustomElementsItem(),
            verticalSpace(20),
            CustomElementsItem(),
            verticalSpace(20),
            CustomElementsItem(),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
