import 'package:drive_doctor/core/app_widgets/app_bar.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/core/app_widgets/text_form_filed.dart';
import 'package:drive_doctor/features/login/presentation/screens/widgets/sign_with_gmail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatelessWidget {
final  bool isLoginWithEmail;
    const SignUp({super.key,required this.isLoginWithEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),

      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          builder: (context, state) {
            var loginCubit = LoginCubit.get(context);
            return SingleChildScrollView(
              child: Form(
                key: loginCubit.signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppBar(
                      isShowBackButton: true,
                      titleWidget:   const Text(
                  "Sign Up",
                  style: TextStyle(
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
                      radius: 80,
                      backgroundImage: loginCubit.userImageUrl != ""
                          ? NetworkImage(loginCubit.userImageUrl)
                          : null,
                      child: loginCubit.userImageUrl == ""
                          ? const Icon(Icons.person, size: 80)
                          : null,
                    ),
                    SizedBox(
                      height: 30.h,
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
                            hintText: "UserName / Email",
                            isObscureText:false ,
                            isReadOnly: isLoginWithEmail,
                            suffixWidget:const SizedBox() ,
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username/email';
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
                            hintText: "Full Name",
                            isReadOnly:false ,
                            suffixWidget:const SizedBox() ,
                            isObscureText:false ,
                            validatorFunction: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username/email';
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
                            hintText: "Password",
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
                              if (value!.isEmpty && value.trim() != "" ) {
                                return 'Please enter a username/email';
                              }
                              else if(loginCubit.txtConfirmPasswordControl.text != loginCubit.txtPasswordControl.text){
                                return 'Password and Confirm Password do not match';
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
                            hintText: "Confirm Password",
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
                              if (value!.isEmpty && value.trim() != "" ) {
                                return 'Please enter a Confirm Password';
                              }
                              else if(loginCubit.txtConfirmPasswordControl.text != loginCubit.txtPasswordControl.text){
                                return 'Password and Confirm Password do not match';
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
                      text: "Sign Up",
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
                                    context: context, isLoginScreen: false);

                              }
                        )
                      ],
                    ),
        
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
