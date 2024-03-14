
import 'package:flutter/material.dart';
import 'package:drive_doctor/features/login/presentation/sign_in/sign_in.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF212121),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[
        
            SizedBox(
              width: 200.w,
              height: 300.0.h,
        
              child: Image.asset(
                "assets/image/6.png",
        
              ),
            ),
        
            Padding(
              padding:   EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Join a community \nof creators',
                    style: TextStyle(
                        color: Color(0xFFcccccf),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(height: 20.h),
                  const Text(
                    'A simple, fun, and creative way to \ntracking and managing your \ncar\'s maintenance',
                    style: TextStyle(
                        color: Color(0xFF777779),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
        SizedBox(height: 70.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
        
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const SignUp()),
                    // );
                  },
                  child: Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF464646)),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFcccccf),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                  SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  child: Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(colors: [
                          Color(0xFFffb421),
                          Color(0xFFff7521)
                        ]),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
