import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:cogina_restaurants/presentation/modules/auth/auth_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/auth/widget/register_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color.dart';
import '../../../../core/resources/styles.dart';
import 'custom_title_tab_bar.dart';
import 'login_body_widget.dart';
import 'login_widget.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  int height =500;
  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 2)
                ]),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 18.w, vertical: 25.h),
                child: SizedBox(
                  height: height.h,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (int val) {
                          if(val==1){
                            setState(() {
                              height=300;
                            });
                          }else{
                            setState(() {
                              height=500;

                            });
                          }
                        },
                        tabs:  <Widget>[
                          CustomTitleTabBarWidget(title: LocaleKeys.register.tr(),),
                          CustomTitleTabBarWidget(title: LocaleKeys.login.tr(),),
                        ],
                        labelStyle: TextStyles.font15CustomGray400Weight,
                        unselectedLabelStyle: TextStyles
                            .font15CustomGray400Weight.copyWith(
                            color: backGroundGray
                        ),
                        indicatorColor: blueColor,
                        labelColor: blueColor,
                        indicatorPadding: EdgeInsets.zero,
                        unselectedLabelColor: black,
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            RegisterWidget(),
                            LoginWidget(),
                            // AuthBodyWidget(type: 'register',),
                            // AuthBodyWidget(type: 'login',),
                          ],
                        ),
                      ),
                    ],

                  ),
                )
            ),
          ),
        ),
      );
  }
}
