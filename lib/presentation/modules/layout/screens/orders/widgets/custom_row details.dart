import 'package:cogina_restaurants/core/resources/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/resources/styles.dart';

class CustomRowDetails extends StatelessWidget {
  const CustomRowDetails({super.key,this.title, this.value, this.dis, this.color, this.fontSize});
  final String? title;
  final String? value;
  final double? dis;
  final double? fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        SizedBox(
          width: dis?? 60.w,
          child: Text(
             title!,
              style: TextStyles.font16Black500Weight.copyWith(
                fontFamily:AppFonts.lateefFont,
                color: color,
                fontSize: fontSize
              ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(
          width:  120.w,
          child: Text(
             ': ${value!}',
              style:
              TextStyles.font16Black500Weight.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.lateefFont,
                color: color,
                fontSize: fontSize
              ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),

      ],
    );
  }
}
