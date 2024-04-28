import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/resources/color.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../../core/resources/decoration.dart';
import '../../../../component/custom_app_bar.dart';
import '../../../../component/custom_elevated_button.dart';
import '../../../../component/cutsom_calendar.dart';
import '../../../orders/widgets/order_provider_item.dart';

class ProfitsScreen extends StatelessWidget {
  const ProfitsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundGray,
      appBar: const CustomAppBar(
        color: backGroundGray,
        title: 'سجل الارباح',
        isBackButtonExist: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: Stack(
                children: [
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      boxShadow: [BoxShadow(color: Colors.black38,blurRadius: 5)]
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('250 دينار',style: TextStyles.font20Black700Weight.copyWith(
                            color: backBlue2
                        ),),
                        Text('اجمالي المحفظة',style: TextStyles.font16Black600Weight),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 25.h,
                    right: MediaQuery.of(context).size.width*0.33,
                    left: MediaQuery.of(context).size.width*0.33,
                    child:
                  Container(
                    height: 37,
                    decoration: Decorations.backGroundDecorationButton().copyWith(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: CustomElevatedButton(
                      backgroundColor: Colors.transparent,
                      onTap: (){
                      },
                      buttonText:'أضف',
                      width: MediaQuery.of(context).size.width*0.35,
                      height: 35,
                      fontSize: 17,
                      borderRadius: 40,
                    ),
                  ),)
                ],
              ),
            ),
            const CustomCalender(),
            verticalSpace(20),
            OrderProviderItem(isProfits: true,),
            verticalSpace(20),
            OrderProviderItem(isProfits: true,),
            verticalSpace(20),
            OrderProviderItem(isProfits: true,),
            verticalSpace(20),
            OrderProviderItem(isProfits: true,),
            verticalSpace(20),
            OrderProviderItem(isProfits: true,),
            verticalSpace(80),

          ],
        ),
      ),
    );
  }
}
