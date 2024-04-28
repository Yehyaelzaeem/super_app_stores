
import 'package:cogina_restaurants/presentation/modules/layout/layout_cubit.dart';
import 'package:cogina_restaurants/presentation/modules/layout/screens/account/edit_profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'navigation_tabs.dart';
import 'widgets/bottom_navigation_bar_widget.dart';

class LayoutScreen extends StatefulWidget {
  final int? _currentPage;
  const LayoutScreen({Key? key,
    required int? currentPage,
  }) : _currentPage = currentPage, super(key: key);
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();


}
class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    getPermission();
    ProfileCubit.get(context).getProfile();
    BlocProvider.of<LayoutCubit>(context, listen: false).init(widget._currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int currentIndex = context.watch<LayoutCubit>().currentIndex;
    final LayoutCubit viewModel = BlocProvider.of<LayoutCubit>(context);
    return  Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PopScope(
        canPop: false,
        onPopInvoked: (c) async {
          if (currentIndex != 0) {
            viewModel.setCurrentIndex(0);
          } else {
            // _nestedNavigator.currentState!.maybePop();
          }
        },
        child:
        kTabs[currentIndex].initialRoute,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        onTap: viewModel.setCurrentIndex,
        currentIndex: currentIndex,
        tabs: kTabs,
      ),
    );
  }
  Future getPermission()async{
    bool service;
    LocationPermission permission;
    service =await Geolocator.isLocationServiceEnabled();
    if(service ==false){
    }
    permission =await Geolocator.checkPermission();
    if(permission ==LocationPermission.denied){
      permission =await Geolocator.requestPermission();
    }
    // Position p ;
    // p=await Geolocator.getCurrentPosition().then((value) => value);
    // List<Placemark> place= await placemarkFromCoordinates(p.latitude,p.longitude);
    return permission;
  }
}
