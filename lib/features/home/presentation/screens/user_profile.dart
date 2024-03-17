import 'package:drive_doctor/core/app_widgets/app_bar.dart';
import 'package:drive_doctor/core/app_widgets/button.dart';
import 'package:drive_doctor/core/services/Global.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeCubit.dart';
import 'package:drive_doctor/features/home/presentation/cubit/homeState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.black,
centerTitle: true,

title:const Text( "Profile",style: TextStyle(color: Colors.white,fontSize: 18),),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<HomeCubit,HomeState>(
          builder: (context,state){
            var homeCubit = HomeCubit.get(context);
            return Container(

              padding: const EdgeInsets.all(25.0),
              height: height,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Color.fromRGBO(34, 34, 34, 1)],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                ),
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: Global.userModel.photoUrl != ""
                            ? NetworkImage( Global.userModel.photoUrl!)
                            : null,
                        child:  Global.userModel.photoUrl == ""
                            ? const Icon(Icons.person, size: 80)
                            : null,
                      ),
                      SizedBox(height: 20.h,),
                      Text( Global.userModel.userFullName??"",
                          style: const TextStyle(color: Colors.white,fontSize: 18)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      AppButton(
                        onTap: () async => homeCubit.logOut(context:context ),
                        secondLinearGradientColor:Colors.blue ,
                        firstLinearGradientColor:Colors.blue ,
                        text: "Sign Out",

                      ),
                      SizedBox(height: 10.h,),
                      AppButton(
                        onTap: () async => homeCubit.userDeleteAccount(context:context ),
                        secondLinearGradientColor:Colors.red ,
                        firstLinearGradientColor:Colors.red ,
                        text: "Delete My Account",

                      ),
                    ],
                  ),
                ],
              ) ,);
          },
          listener: (context,state){

          },

        ),
      ),

    );
  }
}
