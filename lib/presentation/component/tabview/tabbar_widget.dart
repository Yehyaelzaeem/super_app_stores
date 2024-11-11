import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/resources/color.dart';
import '../../../core/resources/fonts/app_fonts.dart';
import '../../../core/resources/styles.dart';

class TabItemModel{
  final String label ;
  final String? image ;
  final Widget page ;
  TabItemModel({required this.label  ,required this.page, this.image});
  Tab builder(){
    return TabWidgetItemBuilder(this);
  }
}

class TabWidgetItemBuilder extends Tab{
  TabWidgetItemBuilder(TabItemModel model, {Key? key}):super(key: key, text: model.label);
}

class TabBarWidget  extends StatelessWidget{
  final Function(int)? onTap;
  final TabController? controllerTapBar;
  final bool? isUnderLine;
  final List<TabItemModel> tabs ;
  const TabBarWidget({super.key ,required this.tabs, this.onTap, this.controllerTapBar, this.isUnderLine});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: whiteColor,
          bottom:
          TabBar(
            controller: controllerTapBar,
            // isScrollable: true,
            indicatorColor: primaryColor,
            // dividerColor: dividerColor,
            unselectedLabelStyle:TextStyles.font15CustomGray400Weight.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.lateefFont,
              fontSize: 10,
              color: customGray
            ),
            labelStyle: TextStyles.font16Black500Weight.copyWith(
              fontWeight: FontWeight.bold,
                fontFamily: AppFonts.lateefFont,

                fontSize: 12,
              color:isUnderLine==true?primaryColor: whiteColor
            ),

            padding:  EdgeInsets.symmetric(horizontal: 0.w,vertical: 0.h),
            indicatorPadding: EdgeInsets.zero,
            labelPadding:  EdgeInsets.zero ,
            indicator:
            isUnderLine==true?
            UnderlineTabIndicator(

              borderSide: BorderSide(color: primaryColor, width: 2.0), // سماكة الخط ولونه
              insets: EdgeInsets.symmetric(horizontal: 16.0), // مسافة الخط الأفقية من الجوانب
            ):
            BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2),
              //     spreadRadius: 1,
              //     blurRadius: 1,
              //     offset: const Offset(0, 1), // changes position of shadow
              //   ),
              // ],

            ),

            indicatorSize: TabBarIndicatorSize.tab,
            onTap: onTap,
            tabs: tabs.map((e) => e.builder()
            ).toList(),
          ),
        ),
        body: TabBarView(
          // physics: const NeverScrollableScrollPhysics(),
          children: tabs.map((e) => e.page).toList(),
        ),
      ),
    );
  }

}
