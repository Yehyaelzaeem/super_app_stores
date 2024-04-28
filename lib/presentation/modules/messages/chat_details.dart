import 'package:cogina_restaurants/core/assets_constant/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color.dart';
import '../../../core/resources/styles.dart';
import '../../component/custom_app_bar.dart';
import '../../component/custom_text_field.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: backGroundGray,
      appBar: CustomAppBar(
        color: backGroundGray,
        title: 'الرسائل',
      ),
        body:Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Column(
                children: <Widget>[
                  ListView.separated(
                    separatorBuilder: (BuildContext c, int i) {
                      return SizedBox(height: 20);
                    },
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext ctx, int index) {
                      return Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(AppImages.bur1),
                            radius: 25,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: ScreenUtil().screenWidth * 0.8,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('أحمد محمد',
                                      style: TextStyles.font18Black700Weight.copyWith(
                                          color: backBlue2
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                padding: EdgeInsets.only(right: 10.w),
                                decoration: const BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 7)],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    )),
                                height: 44.h,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: FittedBox(
                                    child: Text(
                                      'أريد عمل اوردر !',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontFamily: 'Lateef'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                    itemCount: 1,
                    shrinkWrap: true,
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 5.w),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'اكتب...',
                          controller: TextEditingController(),
                          borderRadius: 30,
                          borderColor: primaryColor,
                          prefixIcon: Icon(Icons.attachment_rounded,
                              color: Colors.grey.withOpacity(0.5)),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:primaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              minimumSize: Size(111.w, 50.h)),
                          child: const Text('Send',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ))
          ],
        ),

    );
  }
}
