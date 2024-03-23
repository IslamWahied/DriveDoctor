import 'package:drive_doctor/core/app_widgets/app_bar.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/core/app_widgets/text_form_filed.dart';
import 'package:drive_doctor/features/login/presentation/screens/widgets/sign_with_gmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatelessWidget {
final  bool isLoginWithEmail;
    const SignUp({super.key,required this.isLoginWithEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),

      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: loginCubit.signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10.h,),
                    CustomAppBar(
                      isShowBackButton: true,
                      titleWidget:     Text(
                        AppLocalizations.of(context)!.signUp,
                  style: const TextStyle(
                      color: Color(0xFF909093),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                      onTap:(){
                        LoginCubit.get(context).loginFormKey.currentState?.reset();
                        Navigator.pop(context);
                      } ,
                    ),
                    // Circle For User Profile
                    CircleAvatar(
                      radius: 45.h,
                      backgroundImage: loginCubit.userImageUrl != ""
                          ? NetworkImage(loginCubit.userImageUrl)
                          : null,
                      child: loginCubit.userImageUrl == ""
                          ? const Icon(Icons.person, size: 80)
                          : null,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    // All Text Form Filed
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          // Text Form For UserName / Email
                          AppTextFormFiled(
                            controller:loginCubit.txtEmailControl ,
                            hintText: AppLocalizations.of(context)!.emailHint,
                            isObscureText:false ,
                            isReadOnly: isLoginWithEmail,
                            suffixWidget:const SizedBox() ,
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.emailErrorMessage;
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                         //  Text Form For Full Name
                          AppTextFormFiled(
                            controller: loginCubit.txtFullNameControl ,
                            hintText: AppLocalizations.of(context)!.fullNameHint,
                            isReadOnly:false ,
                            suffixWidget:const SizedBox() ,
                            isObscureText:false ,
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.fullNameErrorMessage;
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          //Text Form For Password
                          AppTextFormFiled(
                            controller: loginCubit.txtPasswordControl,
                            hintText: AppLocalizations.of(context)!.passwordHint,
                            isReadOnly: false,
                            isObscureText:loginCubit.isSignUpPasswordObscureText ,
                            suffixWidget:IconButton(
                              icon: Icon(
                                  loginCubit.isSignUpPasswordObscureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                              onPressed: () {
                                loginCubit.changShowPasswordFlag();
                              },
                            ) ,
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.passwordErrorMessage;
                              }
                              if (value.isEmpty && value.trim() != "" ) {
                                return AppLocalizations.of(context)!.passwordErrorMessage;
                              }
                              else if(loginCubit.txtConfirmPasswordControl.text != loginCubit.txtPasswordControl.text){
                                return AppLocalizations.of(context)!.confirmNotMatchErrorMessage;
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          //Text Form For Confirm Password
                          AppTextFormFiled(
                            controller: loginCubit.txtConfirmPasswordControl,
                            hintText: AppLocalizations.of(context)!.confirmPasswordHint,
                            isReadOnly: false,
                            isObscureText:loginCubit.isSignUpConfirmPasswordObscureText ,
                            suffixWidget: IconButton(
                              icon: Icon(loginCubit
                                  .isSignUpConfirmPasswordObscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () {
                                loginCubit.changShowConfirmPasswordFlag();
                              },
                            ),
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.confirmPasswordErrorMessage;
                              }
                              if (value.isEmpty && value.trim() != "" ) {
                                return AppLocalizations.of(context)!.confirmPasswordErrorMessage;
                              }
                              else if(loginCubit.txtConfirmPasswordControl.text != loginCubit.txtPasswordControl.text){
                                return AppLocalizations.of(context)!.confirmNotMatchErrorMessage;
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 20.h,
                          ),
                          //Text Form For Second Email
                          AppTextFormFiled(
                            controller: loginCubit.txtSecondEmailControl,
                            hintText: AppLocalizations.of(context)!.secondEmailHint,
                            isReadOnly: false,
                            isObscureText:false,
                            suffixWidget:const SizedBox(),
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.secondEmailErrorMessage;
                              }
                              if (  value.trim() == "" ) {
                                return AppLocalizations.of(context)!.secondEmailErrorMessage;
                              }

                              // You can add more validation logic here if needed
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height:isLoginWithEmail ? 70.h : 40.h,
                    ),

                    // Sign Up Button
                    AppButton(
                      text: AppLocalizations.of(context)!.signUp,
                      onTap:  () async {
                        if (loginCubit.signUpFormKey.currentState!
                            .validate()) {
                          // Form is valid, proceed with sign-up logic
                         await   loginCubit.createUserForFireStore(context: context);
                        }
                      },
                      firstLinearGradientColor: const Color(0xFFffb421),
                      secondLinearGradientColor:   const Color(0xFFff7521),
                    ),

                    // SignWithGmail
                    if(!isLoginWithEmail)
                    Column(
                      children: [

                        SizedBox(height: 15.h),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(AppLocalizations.of(context)!.orText,style: const TextStyle(color: Colors.white),)
                          ],
                        ),
                        SizedBox(height: 10.h),
                          SignWithGmail(
                              onTap: () async {

                                await loginCubit.signUpByEmail(
                                    context: context, isLoginScreen: false);

                              }
                        )
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
