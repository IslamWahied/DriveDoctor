
import 'package:drive_doctor/core/app_widgets/app_bar.dart';
import 'package:drive_doctor/core/app_widgets/change_lang.dart';
import 'package:drive_doctor/core/app_widgets/text_form_filed.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';

import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/features/login/presentation/screens/widgets/sign_with_gmail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                   const Align(alignment: Alignment.centerRight,child: ChangeLangButton()),

                   SizedBox(height: 40.h),
                   CustomAppBar(
                     isShowBackButton: false,
                       titleWidget:  Column(
                         children: [
                             Text(
                             AppLocalizations.of(context)!.signIn,
                             style: const TextStyle(
                                 color: Color(0xFF909093),
                                 fontSize: 35,
                                 fontWeight: FontWeight.bold),
                           ),

                             Text(
                               AppLocalizations.of(context)!.loginWelcomeText,
                             style: const TextStyle(
                                 color: Color(0xFF909093),
                                 fontSize: 25,
                                 fontWeight: FontWeight.bold),
                           ),

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
                               return AppLocalizations.of(context)!.emailErrorMessage;
                             }
                             // You can add more validation logic here if needed
                             return null;
                           },
                           suffixWidget:  const SizedBox(),
                           isObscureText:false,
                           hintText:  AppLocalizations.of(context)!.emailHint,

                         ),


                         AppTextFormFiled(
                           controller: loginCubit.txtLoginPasswordControl,
                           isReadOnly:false ,

                           validatorFunction: (value) {
                             if (value!.isEmpty) {
                               return  AppLocalizations.of(context)!.passwordErrorMessage;
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
                           hintText:  AppLocalizations.of(context)!.passwordHint,

                         ),

        
                       ],
                     ),
                   ),
                   SizedBox(height: 60.h),
                   AppButton(
                     text: AppLocalizations.of(context)!.signIn,
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
                         Text(
                           AppLocalizations.of(context)!.anotherAccountText,
                         style: const TextStyle(
                             color: Color(0xFF909093),
                             fontSize: 18,
                             fontWeight: FontWeight.bold),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                             Text(
                             AppLocalizations.of(context)!.accountText,
                             style: const TextStyle(
                                 color: Color(0xFF909093),
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold),
                           ),
                           TextButton(
                               onPressed: () async =>loginCubit.goToSignUp(context: context),
                               child:   Text(
                                 AppLocalizations.of(context)!.signUp,
        
                                 style: const TextStyle(
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
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text( AppLocalizations.of(context)!.orText,style: const TextStyle(color: Colors.white),)
                      ],
                    ),
                   SizedBox(height: 30.h),

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

