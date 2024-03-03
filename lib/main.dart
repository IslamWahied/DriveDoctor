import 'package:drive_doctor/sign_in.dart';
import 'package:drive_doctor/splashScreen.dart';
import 'package:flutter/material.dart';

import 'car.dart';
import 'home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme: ThemeData(
          useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,

      home:
      const
       // HomeScreen(),
           SplashScreen(),
      // SignInScreen(),
     // CarDetailsScreen(),
      //   SplashScreen(),
    );
  }
}
