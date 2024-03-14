import 'package:bloc/bloc.dart';
import 'package:drive_doctor/core/network/auth/google_signIn_service.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:drive_doctor/features/login/presentation/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);


   // login
  GlobalKey<FormState>  loginFormKey = GlobalKey<FormState>();
  TextEditingController  txtLoginEmailControl =     TextEditingController();
  TextEditingController  txtLoginPasswordControl =     TextEditingController();
  bool isLoginPasswordObscureText = true;
  login(){}


  // SignUp
  GlobalKey<FormState>  signUpFormKey = GlobalKey<FormState>();
  TextEditingController  txtEmailControl =     TextEditingController();
  TextEditingController  txtFullNameControl =     TextEditingController();
  TextEditingController  txtPasswordControl =     TextEditingController();
  TextEditingController  txtConfirmPasswordControl = TextEditingController();
  bool isSignUpPasswordObscureText = true;
  bool isSignUpConfirmPasswordObscureText = true;
  signUpByEmail({required BuildContext context}) async {
    GoogleSignInService googleSignInService =
    GoogleSignInService();
    bool isGoogleSignedIn =
    googleSignInService.isGoogleSignedIn();

    await googleSignInService.signOutGoogle();

    if (!isGoogleSignedIn) {
      var result = await googleSignInService.signInWithGoogle();

      if(result != null){
        txtEmailControl.text = result.email;
        txtFullNameControl.text = result.displayName!;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SignUp(
                email: result.email,
                userImageUrl: result.photoUrl!,
                userFullName: result.displayName!,

              )),
        );
      }

    } else {
      await googleSignInService.signOutGoogle();
    }
  }

  changeLoginShowPasswordFlag(){
    isLoginPasswordObscureText = !isLoginPasswordObscureText;
    emit(ChangShowPasswordFlagState());
  }

  changShowPasswordFlag(){
    isSignUpPasswordObscureText = !isSignUpPasswordObscureText;
    emit(ChangShowPasswordFlagState());
  }

  changShowConfirmPasswordFlag(){
    isSignUpConfirmPasswordObscureText = !isSignUpConfirmPasswordObscureText;
    emit(ChangShowConfirmPasswordFlagState());
  }

}