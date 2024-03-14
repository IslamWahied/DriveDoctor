import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SignUp extends StatelessWidget {
final String userImageUrl;
final String userFullName;
final String email;




    const SignUp({super.key,required this.userFullName,required this.email,required this.userImageUrl});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
   
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF909093)),
          onPressed: () => Navigator.of(context).pop(),
        ),



      ),


      body:BlocConsumer<LoginCubit,LoginState>(
        builder: (context,state){
          var loginCubit = LoginCubit.get(context);
          return  SingleChildScrollView(
            child: Form(
              key: loginCubit.signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Center(
                    child: Text('Sign up',style:
                    TextStyle(
                        color: Color(0xFF909093),
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  SizedBox(height: 30.h,),

                  CircleAvatar(
                    radius: 80,
                    backgroundImage: userImageUrl != null ? NetworkImage(userImageUrl) : null,
                    child: userImageUrl == null ? const Icon(Icons.person, size: 80) : null,
                  ),
                  SizedBox(height: 30.h,),

                  Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[


                        Container(

                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey))
                          ),
                          child:   TextFormField(
                            controller: loginCubit.txtEmailControl,
                            style: const TextStyle(
                              color: Colors.white,

                            ),
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: "UserName / Email",
                                hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent
                                    )
                                ),

                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username/email';
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 20.h,),

                        Container(

                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey))
                          ),
                          child:   TextFormField(

                            controller: loginCubit.txtFullNameControl,
                            style: const TextStyle(
                              color: Colors.white,

                            ),
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Full Name",
                                hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent
                                    )
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username/email';
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 20.h,),

 //Password
                        Container(

                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey))
                          ),

                          child:TextFormField(
                            controller: loginCubit.txtPasswordControl,
                            obscureText: loginCubit.isSignUpPasswordObscureText,
                            style: const TextStyle(
                              color: Colors.white,

                            ),
                            decoration:   InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(loginCubit.isSignUpPasswordObscureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                  onPressed: () {
                                    loginCubit
                                        .changShowPasswordFlag();
                                  },
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.grey,fontSize: 14),
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent)
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username/email';
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },


                          ),
                        ),

                        SizedBox(height: 20.h,),

                      // Confirm Password
                        Container(

                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey))
                          ),

                          child:TextFormField(
                            controller: loginCubit.txtConfirmPasswordControl,
                            obscureText: loginCubit.isSignUpConfirmPasswordObscureText,
                            style: const TextStyle(
                              color: Colors.white,

                            ),
                            decoration:   InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(loginCubit.isSignUpConfirmPasswordObscureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                  onPressed: () {
                                    loginCubit
                                        .changShowConfirmPasswordFlag();
                                  },
                                ),
                                hintText: "Confirm Password",
                                hintStyle: const TextStyle(color: Colors.grey,fontSize: 14),
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent)
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a username/email';
                              }
                              // You can add more validation logic here if needed
                              return null;
                            },
                          ),
                        ),






                      ],
                    ),
                  ),
                  SizedBox(height: 100.h,),
                  Container(
                      height: 50.h,
                      width: 320.w,

                      // margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFFffb421),
                              Color(0xFFff7521)
                            ]
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (loginCubit.signUpFormKey.currentState!.validate()) {
                            // Form is valid, proceed with sign-up logic
                            await FirebaseAuth.instance.signInAnonymously().then((value) {
                              // Handle successful sign-up
                            });
                          }


                          await  FirebaseAuth.instance.signInAnonymously().then((value) {

                          });
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()),);
                        },
                        child: const Center(
                          child: Text("Sign Up", style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      )
                  ),
                  SizedBox(height: 10.h,),

                ],
              ),
            ),
          );
        },
        listener: (context,state){

        },
      ),
    );
  }
}
