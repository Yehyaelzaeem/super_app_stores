import 'package:cogina_restaurants/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:audioplayers/audioplayers.dart';

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
  AudioPlayer player = AudioPlayer();

  static play(String src) async {
    final player = AudioPlayer();
    await player.play(AssetSource(src));
  }
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
      navigationPage();
    });
    super.initState();

  }
  @override
  dispose() {
    _animationController!.dispose(); // you need this
    super.dispose();
  }



  navigationPage() async{
    AuthCubit.get(context).changeType('auth');
    bool isAuthed = await _viewModel.isLogin();
    if (isAuthed) {
      NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen,arguments: {'currentPage':0});
    }else{
      dioClient.token=null;
      NavigationService.pushNamedAndRemoveUntil(Routes.authScreen);
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          // decoration:Decorations.backGroundDecorationCircleBorderRadius(),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              Positioned(
                top: height * 0.4,
                left:isWeltApp==true?null:width * 0.1,
                child: SlideTransition(
                  position: _animation!,
                  child: AnimatedContainer(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topLeft,
                    duration: const Duration(seconds: 0),
                    child:
                        isWeltApp==true?
                      SizedBox(
                        height: height * 0.2 + 20,
                        child: const CustomLogo(),
                      ):
                    Image(
                      height: height * 0.2 + 20,
                      width: width * 0.8 + 10,
                      fit: BoxFit.contain,
                      image: const AssetImage(AppImages.logo2),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 20.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //       SizedBox(
              //       width: width*0.9,
              //       child: DefaultTextStyle(
              //         style: const TextStyle(
              //           fontSize: 30.0,
              //           fontFamily: 'Bobbers',
              //         ),
              //         child: AnimatedTextKit(
              //           animatedTexts: [
              //             TyperAnimatedText('مَرْحَبًا بِكُمْ فِي كوجينا، حَيْثُ نَقُدِّمُ لَكُمْ تَجْرِبَةَ طَعَامٍ إِسْتِثْنَائِيَّةً عَبَرَ أَطْيَافِ مُتَعَدِّدَةٍ مِنَ المَأْكُولَاتِ الشَّهِيَّةِ وَالمُخْتَلِفَةِ',textStyle: TextStyles.font20Black700Weight.copyWith(
              //               height: 0.8,
              //               fontSize: 16
              //             )),
              //
              //           ],
              //           onTap: () {
              //             print("Tap Event");
              //           },
              //         ),
              //       ),
              //     )
              //
              //
              //       ],
              //     ),
              //   ),
              // ),
            ],
          )),
    );
  }
}

