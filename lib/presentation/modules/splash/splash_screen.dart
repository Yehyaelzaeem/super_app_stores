import 'package:cogina_restaurants/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../data/app_urls/app_url.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/injection.dart';
import '../../../../domain/provider/local_auth_provider_cubit.dart';
import '../../../../data/injection.dart' as data_injection;
import '../../../core/assets_constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/color.dart';
import '../../../core/resources/decoration.dart';
import '../../component/custom_logo.dart';
import '../auth/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;
  // AudioPlayer player = AudioPlayer();
  // void playSoundEffect() async {
  //   await player.setSource(AssetSource('assets/mp3/splash.mp3'));
  // }
  // AudioCache audioCache = AudioCache();

  // void loadSoundEffect() async {
  //   await audioCache.load('assets/mp3/splash.mp3');
  // }


  Animation<Offset>? _animation;
  late final LocalAuthCubit _viewModel;
  DioClient dioClient =DioClient(AppURL.kBaseURL, getIt(),loggingInterceptor: getIt(), cacheConsumer: getIt());
  @override
  void initState() {

    _viewModel = BlocProvider.of<LocalAuthCubit>(context, listen: false);
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.9),
      end: Offset.zero,
    ).animate(_animationController!);
    // play('mp3/splash2.mp3',);
    _animationController!.forward().whenComplete(() {
      getPermission().then((value) {
        navigationPage();
      });
    });
    super.initState();

  }
  @override
  dispose() {
    _animationController!.dispose(); // you need this
    super.dispose();
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
  navigationPage() async{
    context.read<LocalAuthCubit>().getLocation();
    AuthCubit.get(context).changeType('auth');
    bool isAuthed = await _viewModel.isLogin();
    if (isAuthed) {
      NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen,arguments: {'currentPage':0});
    }else{
      dioClient.token=null;
      NavigationService.pushNamedAndRemoveUntil(Routes.authScreen);
    }
  }

    // Position p ;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Image.asset(AppImages.logo3,
          height: height,
          width: width,
        )
    );
  }
}

