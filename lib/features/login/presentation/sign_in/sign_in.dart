
import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:drive_doctor/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),

      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF212121),
      //   centerTitle: true,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Color(0xFF909093)),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),

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
        SizedBox(height: 50.h,),
                   Column(
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
                   SizedBox(height: 40.h),
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal:25.w),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         TextFormField(
                           controller: loginCubit.txtLoginEmailControl,
                           style: const TextStyle(
                             color: Colors.white,
                           ),
                           decoration: const InputDecoration(
                               fillColor: Colors.white,
                               hintText: "UserName / Email",
                               hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                               border: UnderlineInputBorder(
                                   borderSide: BorderSide(color: Colors.blueAccent))),
                           validator: (value) {
                             if (value!.isEmpty) {
                               return 'Please enter a username/email';
                             }
                             // You can add more validation logic here if needed
                             return null;
                           },
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         TextFormField(
                             obscureText: loginCubit.isLoginPasswordObscureText,
                             style: const TextStyle(
                               color: Colors.white,
                             ),
                             decoration:   InputDecoration(
                                 hintText: "Password",
                                 hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                                 suffixIcon: IconButton(
                                   icon: Icon(loginCubit.isLoginPasswordObscureText
                                       ? Icons.visibility_off_outlined
                                       : Icons.visibility_outlined),
                                   onPressed: () {
                                     loginCubit
                                         .changeLoginShowPasswordFlag();
                                   },
                                 ),
        
        
                                 border: const UnderlineInputBorder(
                                     borderSide: BorderSide(color: Colors.blueAccent))
        
                             ),
                             validator: (value) {
                               if (value!.isEmpty) {
                                 return 'Please enter a password';
                               }
                               // You can add more validation logic here if needed
                               return null;
                             },
                           ),
        
                       ],
                     ),
                   ),
                   SizedBox(height: 100.h),
                   GestureDetector(
                     onTap: (){
                    if (loginCubit.loginFormKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
        
                      );
                    }
        
                     },
                     child: Container(
                         height: 50.h,
                         width: 320.w,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           gradient: const LinearGradient(
                               colors: [Color(0xFFffb421), Color(0xFFff7521)]),
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
                               onPressed: () async {
        
        
                                 // Navigator.push(
                                 //   context,
                                 //   // MaterialPageRoute(builder: (context) => const SignUp()),
                                 // );
                               },
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
                   SizedBox(height: 20.h),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: InkWell(
                       onTap: () async {
                       loginCubit.signUpByEmail(context: context);
                       },
                       child: Container(
                         padding: const EdgeInsets.all(
                             8     ),
                         width: double.infinity,
                         decoration: const BoxDecoration(
                           color:  Colors.black38  ,
        
                         ),
                         child: Row(
                           crossAxisAlignment:
                           CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Image.asset(
                               'assets/image/google.png',
                               width: 30  ,
                               height: 30    ,
                             ),
                             Center(
                               child: Text('CONNECT WITH GOOGLE',
                                   textAlign: TextAlign.center,
                                   style: Theme.of(context)
                                       .textTheme
                                       .displayLarge
                                       ?.copyWith(
                                       fontSize: 12  ,
                                       fontWeight:
                                       FontWeight.w600,
        
                                       letterSpacing:
                                       0.8000000119  ,
                                       color: const Color(
                                           0xffffffff))),
                             ),
                             const SizedBox()
                           ],
                         ),
                       ),
                     ),
                   ),
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

