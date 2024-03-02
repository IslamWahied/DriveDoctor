
import 'dart:async';
import 'package:drive_doctor/welcome.dart';

import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = const TextStyle(

      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4800), () {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const WelcomePage()),);

  });

  }

  @override
  Widget build(BuildContext context)
    {
      return Scaffold(
backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/image/5.gif",
                      width: 400,
                    ),
                  ),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10,),

                ]),
          ),
        ),
      );
    }
}
