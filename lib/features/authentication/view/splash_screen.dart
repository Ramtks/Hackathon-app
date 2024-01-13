import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:hackathon_app/utils/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.authenticationStatus == AuthenticationStatus.loading)
                LoadingAnimationWidget.hexagonDots(
                  color: Colors.white,
                  size: 40,
                ),
              if (state.authenticationStatus == AuthenticationStatus.error)
                TextButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.boxColor),
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      'حاول مرة اخرى',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onPressed: () {}),
            ],
          );
        },
      ),
    );
  }
}
