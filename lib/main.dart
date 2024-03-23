import 'package:drive_doctor/Model/user.dart';
import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';
import 'package:drive_doctor/features/home/presentation/screens/home.dart';
import 'package:drive_doctor/features/login/presentation/screens/wellcom/welcome.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/services/Global.dart';
import 'features/home/presentation/cubit/homeCubit.dart';
import 'features/login/presentation/cubit/loginCubit.dart';
import 'features/login/presentation/screens/sign_in/sign_in.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  CashHelper.init();


  // fire base
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance;
  // FirebaseMessaging.onMessage.listen((event) {
  //   // print('onMessage');
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   // print('A new onMessageOpenedApp event was published!');
  //   // Navigator.pushNamed(context, '/message',
  //   //     arguments: MessageArguments(message, true));
  // });
  // Global.fireBaseToken = await FirebaseMessaging.instance.getToken() ?? '';

  // check is Show Welcome Screen Login
  bool isShowWelcomeScreen =
      CashHelper.getData(key: StringManager.isShowWelcomeScreen)??false;

 String lang =  CashHelper.getData(key: "lang")??'en';

 if(lang.isNotEmpty && lang.isNotEmpty){

 StringManager.appLang =lang;
 }



  // check is User Login
  bool isUserLogin = CashHelper.getData(key: StringManager.isUserLogin)??false;
  if(isUserLogin){
    Global.userModel = UserModel.getUserModel()!;
  }

// whenever your initialization is completed, remove the splash screen:
 await Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });


  runApp(MyApp(isShowWelcomeScreen: isShowWelcomeScreen,isUserLogin: isUserLogin));
}
class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(  Locale(StringManager.appLang));


  static LanguageCubit get(context) => BlocProvider.of(context);

  void changeLanguage(Locale newLocale) => emit(newLocale);
}
class MyApp extends StatelessWidget {
 final bool isShowWelcomeScreen;
 final bool isUserLogin;
  const MyApp({Key? key, required this.isShowWelcomeScreen, required this.isUserLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return  MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LanguageCubit()),
            BlocProvider(create: (context)=>LoginCubit()),
            BlocProvider(create: (context)=>HomeCubit()..getBrandsModels()),

          ],

          child :BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: locale,
                supportedLocales: const [
                  Locale("en"),
                  Locale("ar"),
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  // Your logic to determine the locale dynamically
                  // For example, you can use the device's locale or any other criteria
                  // Here we are just returning the first supported locale
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == deviceLocale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  // If the device locale is not supported, fallback to the first locale
                  return supportedLocales.first;
                },
                debugShowCheckedModeBanner: false,
                title: StringManager.appName,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                ),
                home: child,
              );
            },
          ),
        );
      },


      child:

     !isShowWelcomeScreen? const WelcomePage() :

     !isUserLogin ? const SignInScreen() :

      const HomeScreen(),



    );
  }
}
