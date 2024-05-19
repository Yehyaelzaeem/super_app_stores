
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/helpers/spacing.dart';
import '../../core/resources/color.dart';
import '../../core/resources/styles.dart';

class CustomNotFoundDataWidget extends StatelessWidget {
  const CustomNotFoundDataWidget({super.key, required  this.title, required this.type, required this.image});
  final String image;
  final String title;
  final String type;
  @override
  Widget build(BuildContext context) {
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        type=='png'?
        Expanded(child: Image.asset(image)):
        Expanded(child: SvgPicture.asset(image,)),
        Text(title,
            style: TextStyles.font18Black700Weight.copyWith(
                color: customBlack.withOpacity(0.6)
            ),
        ),
        verticalSpace(100),
      ],
    );
  }
}
