import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/core/app_widgets/change_lang.dart';

import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            child: Center(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Align(alignment: Alignment.centerRight,child: ChangeLangButton()),


                    // Car Image
                    SizedBox(
                      width: 190.w,
                      height: 200.0.h,
                      child: Image.asset(
                        "assets/image/Logo.png",
                        color: Colors.grey[300],
                      ),
                    ),
                
                    // Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                               AppLocalizations.of(context)!.firstWelcomeText,
                            style: const TextStyle(
                                color: Color(0xFFcccccf),
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(height: 20.h),
                            Text(
                            AppLocalizations.of(context)!.secondWelcomeText,
                            style: const TextStyle(
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
                            text: AppLocalizations.of(context)!.signUp,
                            onTap:()=> loginCubit.goToSignUp(context: context),
                            firstLinearGradientColor: const Color(0xFF464646),
                            secondLinearGradientColor: const Color(0xFF464646)),
                        SizedBox(
                          height: 30.h,
                        ),
                        AppButton(
                            text: AppLocalizations.of(context)!.signIn,
                            onTap:()=>loginCubit.goToLogin(context: context),
                            firstLinearGradientColor: const Color(0xFFffb421),
                            secondLinearGradientColor: const Color(0xFFff7521)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
