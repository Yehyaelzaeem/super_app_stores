import 'package:flutter/material.dart';
import '../../../../../../../core/resources/styles.dart';

class ProductTitleField extends StatelessWidget {
  const ProductTitleField({super.key, required this.title});
 final String title;
  @override
  Widget build(BuildContext context) {
    return  Text('  $title',
      style: TextStyles.font18Black700Weight.copyWith(
          color: Colors.grey.shade700
      ),
    );
  }
}
