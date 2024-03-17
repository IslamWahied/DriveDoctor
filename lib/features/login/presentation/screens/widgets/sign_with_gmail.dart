import 'package:drive_doctor/features/login/presentation/cubit/loginCubit.dart';
import 'package:drive_doctor/features/login/presentation/cubit/loginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignWithGmail extends StatelessWidget {
    final void Function()? onTap;
    const SignWithGmail({super.key,@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<LoginCubit,LoginState>(
      builder: (context,state){
        var loginCubit = LoginCubit.get(context);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black38,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/image/google.png',
                    width: 30,
                    height: 30,
                  ),
                  Center(
                    child: Text('CONNECT WITH GOOGLE',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8000000119,
                            color: const Color(0xffffffff))),
                  ),
                  const SizedBox()
                ],
              ),
            ),
          ),
        );
      },
      listener: (context,state){},

    );
  }
}
