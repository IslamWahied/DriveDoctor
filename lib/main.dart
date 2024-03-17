import 'package:drive_doctor/Model/user.dart';
import 'package:drive_doctor/core/services/StringManager.dart';
import 'package:drive_doctor/core/services/shared_helper.dart';
import 'package:drive_doctor/features/home/presentation/screens/home.dart';
import 'package:drive_doctor/features/login/presentation/screens/wellcom/welcome.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/services/Global.dart';
import 'features/home/presentation/cubit/homeCubit.dart';
import 'features/login/presentation/cubit/loginCubit.dart';
import 'features/login/presentation/screens/sign_in/sign_in.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  CashHelper.init();

  // fire base
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance;
  FirebaseMessaging.onMessage.listen((event) {
    // print('onMessage');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print('A new onMessageOpenedApp event was published!');
    // Navigator.pushNamed(context, '/message',
    //     arguments: MessageArguments(message, true));
  });
  Global.fireBaseToken = await FirebaseMessaging.instance.getToken() ?? '';

  // check is Show Welcome Screen Login
  bool isShowWelcomeScreen =
      CashHelper.getData(key: StringManager.isShowWelcomeScreen)??false;

  print("isShowWelcomeScreen");
  print(isShowWelcomeScreen);

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

            BlocProvider(create: (context)=>LoginCubit()),
            BlocProvider(create: (context)=>HomeCubit()..getBrandsModels()),

          ],
          child :MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            ),
            home: child,
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
