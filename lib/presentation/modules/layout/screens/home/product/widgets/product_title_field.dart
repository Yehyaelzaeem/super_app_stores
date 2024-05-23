import 'package:flutter/material.dart';
import '../../../../../../../core/resources/styles.dart';

class ProductTitleField extends StatelessWidget {
  const ProductTitleField({super.key, required this.title, this.color});
 final String title;
 final Color? color;
  @override
  Widget build(BuildContext context) {
    return  Text('  $title',
      style: TextStyles.font18Black700Weight.copyWith(
          color:color?? Colors.grey.shade700,
        height: 1,
      ),
      textAlign: TextAlign.center,
    );
  }
}
