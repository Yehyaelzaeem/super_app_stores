import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:cogina_restaurants/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_constant/images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';

class PersonChatWidget extends StatelessWidget {
  const PersonChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: (){
          context.pushNamed(Routes.chatDetailsScreen);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: const [BoxShadow(color: Colors.black26,blurRadius: 2)]
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
            child:
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppImages.pro2),
                ),
                horizontalSpace(10),
                Column(
                  children: [
                    Text('مريم',style: TextStyles.font18Black700Weight.copyWith(
                        color: backBlue2
                    ),),
                    Text('اين انتى ؟',style: TextStyles.font18Black700Weight.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor:backBlue2,
                      child: Text('6',style: TextStyle(color: Colors.white),
                      ),
                    ),
                    verticalSpace(5),
                    Text('13 نوفمبر 2023',style: TextStyles.font18Black700Weight.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    ),),
                  ],
                ),
                horizontalSpace(10),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
