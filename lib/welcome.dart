import 'package:flutter/material.dart';
import 'package:drive_doctor/sign_in.dart';
import 'package:drive_doctor/sign_up.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF212121),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              const SizedBox(height: 25),
                  SizedBox(
                    width: 250.0,
                    height: 200.0,

                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Image.asset(
                        "assets/image/6.png",

                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'Join a community \nof creators',
                        style: TextStyle(
                            color: Color(0xFFcccccf),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child:
                          // FadeAnimation(1.6,
                          Text(
                        'A simple, fun, and creative way to \ntracking and managing your \ncar\'s maintenance',
                        style: TextStyle(
                            color: Color(0xFF777779),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                      // ),
                      ),
                  const SizedBox(height: 120),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: Container(
                            height: 50,
                            width: 320,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFF464646)),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFcccccf),
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                      // ),
                      ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        },
                        child: Container(
                            height: 50,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(colors: [
                                Color(0xFFffb421),
                                Color(0xFFff7521)
                              ]),
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
                      )
                      // ),
                      ),
                ],
              ),
            )),
      ),
    );
  }
}
