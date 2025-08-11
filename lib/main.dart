import 'package:cogina_restaurants/presentation/modules/auth/complete_profile/complete_profile_screen.dart';
import 'package:cogina_restaurants/presentation/modules/splash/splash_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc.dart';
import 'firebase_options.dart';
import 'injection.dart' as injection;
import 'data/injection.dart' as data_injection;
import 'core/resources/color.dart';
import 'core/routing/navigation_services.dart';
import 'core/routing/route_generator.dart';
import 'domain/injection.dart' as domain_injection;
/// 11/8/2025  
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await data_injection.init();
  await domain_injection.init();
  //super-app-asia.
  await injection.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp( GenerateMultiBloc(
      child:   EasyLocalization(
        supportedLocales: supportedLocales,
        path: 'assets/translation',
        fallbackLocale: supportedLocales[0],
        saveLocale: true,
        useOnlyLangCode: true,
        startLocale: supportedLocales[0],
        child: MyApp(),
      )));
}
final supportedLocales = <Locale>[
  const Locale('ar'),
  const Locale('en'),
];
BuildContext appContext=NavigationService.navigationKey.currentContext!;
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title:
            'Super App Stores',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigationKey,
            onGenerateRoute: RouteGenerator.generateBaseRoute,
            localizationsDelegates: [CountryLocalizations.delegate, ...context.localizationDelegates,],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              primaryColor: primaryColor,
              // AppColors.primaryColor,
              primaryColorDark: primaryColorDark,
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor.withOpacity(0.5)),
              useMaterial3: true,
            ),
            home:  SplashScreen(),


          );
        },
      );
  }
}
