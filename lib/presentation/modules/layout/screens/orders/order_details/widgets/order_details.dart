import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color.dart';
import '../../../../../../../core/resources/styles.dart';

class OrderDetailsWidget extends StatelessWidget {
  final String title;
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  const OrderDetailsWidget({Key? key, required this.title, this.onTap, required this.text, this.icon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: whiteColor,
              boxShadow: const [BoxShadow(color: Colors.black12,blurRadius: 3)],
              border: Border.all(color: primaryColor.withOpacity(0.4),width: 1)
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Center(
                    child: Text(
                      title,
                      style: TextStyles.font20Black700Weight.copyWith(

                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  )),
                  SizedBox(
                    height: 35.h,
                    child:  VerticalDivider(thickness: 1,color: primaryColor.withOpacity(0.4),endIndent: 2.w,indent: 2.w,),
                  ),
                  Expanded(child:Center(child:    Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Icon(icon??Icons.location_on,color:primaryColor.withOpacity(0.4),size: 23.sp,),)))
                ],
              ),
              Divider(thickness: 1,color: primaryColor.withOpacity(0.4),),
              Padding(padding:EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h) ,
                child: Text(
                  text,
                  style: TextStyles.font20Black700Weight.copyWith(
                      fontWeight: FontWeight.w600,
                      color: customGray,
                      fontSize: 13.sp),),
              )
            ],
          ),
        ),
      );
  }
}
