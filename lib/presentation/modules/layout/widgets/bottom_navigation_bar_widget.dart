import 'package:cogina_restaurants/core/resources/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/tabs/tab.dart';
import '../../../../core/resources/color.dart';
import '../../../component/animation/tap_effect.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final ValueChanged<int> _onTap;
  final int _currentIndex;
  final List<NavigationTab> _tabs;

  const BottomNavigationBarWidget({
    Key? key,
    required ValueChanged<int> onTap,
    required int currentIndex,
    required List<NavigationTab> tabs,
  })  : _onTap = onTap,
        _currentIndex = currentIndex,
        _tabs = tabs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 12.sp,
      selectedItemColor: Theme.of(context).primaryColor,
      // type: BottomNavigationBarType.shifting,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).cardColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle:const TextStyle().descriptionStyle().activeColor(),
      unselectedLabelStyle:const TextStyle().descriptionStyle(),
      onTap: _onTap,
      currentIndex: _currentIndex,
      items: [..._generateTags(context)],
    );
  }

  _generateTags(BuildContext context) {
    return _tabs.map((tab) => _buildItem(context,tab)).toList();
  }

  _buildItem(BuildContext context, NavigationTab tab) {
    return BottomNavigationBarItem(
      label: tab.name,
      icon: TapEffect(
        onClick: () => _onTap(tab.index),
        child:
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backRed1, backBlue2],
            ).createShader(bounds);
          },
          child:Icon(_currentIndex== tab.index? tab.selectIcon: tab.unSelectIcon,color: _currentIndex== tab.index? Theme.of(context).primaryColor: Theme.of(context).hintColor),

        )

        // child: SvgPicture.asset(tab.image,
        //     height: 28.r, width: 28.r, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
