
import 'package:drive_doctor/core/app_widgets/app_bar.dart';
import 'package:drive_doctor/core/app_widgets/text_form_filed.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';

import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/features/login/presentation/screens/widgets/sign_with_gmail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: BlocConsumer<LoginCubit,LoginState>(
         listener: (context,state){},
          builder:  (context,state){
           var loginCubit = LoginCubit.get(context);
           return  Form(

             key: loginCubit.loginFormKey,
             child: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomAppBar(
                     isShowBackButton: false,
                       titleWidget:  Column(
                         children: [
                           const Text(
                             'Sign In',
                             style: TextStyle(
                                 color: Color(0xFF909093),
                                 fontSize: 35,
                                 fontWeight: FontWeight.bold),
                           ),
                           SizedBox(
                             height: 10.h,
                           ),
                           const Text(
                             'Welcome Back',
                             style: TextStyle(
                                 color: Color(0xFF909093),
                                 fontSize: 25,
                                 fontWeight: FontWeight.bold),
                           ),
                           SizedBox(height: 70.h),
                         ],
                       ),
                   ),
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal:25.w),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[

                         AppTextFormFiled(
                           controller: loginCubit.txtLoginEmailControl,
                           isReadOnly:false ,
                           validatorFunction: (value) {
                             if (value!.isEmpty) {
                               return 'Please enter a username/email';
                             }
                             // You can add more validation logic here if needed
                             return null;
                           },
                           suffixWidget:  const SizedBox(),
                           isObscureText:false,
                           hintText: "UserName / Email",

                         ),

                         SizedBox(
                           height: 10.h,
                         ),
                         AppTextFormFiled(
                           controller: loginCubit.txtLoginPasswordControl,
                           isReadOnly:false ,

                           validatorFunction: (value) {
                             if (value!.isEmpty) {
                               return 'Please enter a password';
                             }
                             // You can add more validation logic here if needed
                             return null;
                           },
                           suffixWidget:  IconButton(
                             icon: Icon(loginCubit.isLoginPasswordObscureText
                                 ? Icons.visibility_off_outlined
                                 : Icons.visibility_outlined),
                             onPressed: () {
                               loginCubit
                                   .changeLoginShowPasswordFlag();
                             },
                           ),
                           isObscureText: loginCubit.isLoginPasswordObscureText,
                           hintText: "Password",

                         ),

        
                       ],
                     ),
                   ),
                   SizedBox(height: 100.h),
                   AppButton(
                     text: "Sign In",
                     onTap: () async {
                       if (loginCubit.loginFormKey.currentState!.validate()) {
                         await loginCubit.login(context: context);

                       }

                     },
                     firstLinearGradientColor: const Color(0xFFffb421),
                     secondLinearGradientColor:   const Color(0xFFff7521),
                   ),
                   SizedBox(height: 40.h),
                   Column(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       const Text(
                         'Or sign up with another',
                         style: TextStyle(
                             color: Color(0xFF909093),
                             fontSize: 18,
                             fontWeight: FontWeight.bold),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const Text(
                             'account.',
                             style: TextStyle(
                                 color: Color(0xFF909093),
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold),
                           ),
                           TextButton(
                               onPressed: () async =>loginCubit.goToSignUp(context: context),
                               child: const Text(
                                 'sign up',
        
                                 style: TextStyle(
                                     decoration: TextDecoration.underline,
                                     color: Colors.blue,
                                     fontSize: 18,
        
                                     fontWeight: FontWeight.bold),
                               )),
                         ],
                       ),
                     ],
                   ),
                   SizedBox(height: 10.h),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("OR",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                   SizedBox(height: 10.h),
                    SignWithGmail(
                     onTap: () async {

                       await loginCubit.signUpByEmail(
                           context: context, isLoginScreen: true);

                     }
                   )
                 ],
               ),
             ),
           );
          },
        ),
      ),
    );
  }
}

