import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF212121),
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Car Image
                SizedBox(
                  width: 200.w,
                  height: 300.0.h,
                  child: Image.asset(
                    "assets/image/6.png",
                  ),
                ),

                // Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
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

                SizedBox(
                  height: 70.h,
                ),

                // buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton(
                        text: "Sign Up",
                        onTap:()=> loginCubit.goToSignUp(context: context),
                        firstLinearGradientColor: const Color(0xFF464646),
                        secondLinearGradientColor: const Color(0xFF464646)),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppButton(
                        text: "Sign In",
                        onTap:()=>loginCubit.goToLogin(context: context),
                        firstLinearGradientColor: const Color(0xFFffb421),
                        secondLinearGradientColor: const Color(0xFFff7521)),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
