import 'package:drive_doctor/splashScreen.dart';
import 'package:drive_doctor/welcome.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/login/presentation/cubit/loginCubit.dart';
import 'features/login/presentation/sign_in/sign_in.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance;

  // fire base
  FirebaseMessaging.onMessage.listen((event) {
    // print('onMessage');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // print('A new onMessageOpenedApp event was published!');
    // Navigator.pushNamed(context, '/message',
    //     arguments: MessageArguments(message, true));
  });

   String fireBaseToken = await FirebaseMessaging.instance.getToken() ?? '';

   print(fireBaseToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        //  const WelcomePage(),
       // const SplashScreen(),
      const  SignInScreen(),
      // CarDetailsScreen(),
      //   SplashScreen(),
      // const HomePage(title: 'First Method'),



    );
  }
}
