import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/app_routes.dart';
import 'package:hackathon_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:hackathon_app/features/components/action_button.dart';
import 'package:hackathon_app/features/components/custom_form_text_field.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Column(children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svgs/streamy.svg',
                  color: Colors.white,
                ),
                Text(
                  'Streamy',
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
              child: Column(
                children: [
                  CustomTextField(
                      errorText: state.email.getErrorMessage ?? '',
                      borderRadius: 25,
                      initialText: state.email.getValue,
                      hintText: "Email",
                      showError: !state.email.getIsValid,
                      onChange: (value) {
                        context
                            .read<AuthenticationBloc>()
                            .add(EmailChanged(value));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      isObsecure: true,
                      borderRadius: 25,
                      errorText: state.password.getErrorMessage ?? '',
                      initialText: state.password.getValue,
                      hintText: "Password",
                      showError: !state.password.getIsValid,
                      onChange: (value) {
                        context
                            .read<AuthenticationBloc>()
                            .add(PasswordChanged(value));
                      }),
                  Row(
                    children: [
                      TextButton(
                        child: Text(
                          'Signup instead?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                        onPressed: () =>
                            context.pushReplacementNamed(AppRoutes.signupPage),
                      )
                    ],
                  )
                ],
              ),
            ),
            ActionButton(
              isLoading: state.signinButtonStatus == SigninButtonStatus.loading,
              isDisabled: state.isSigninButtonDisabled,
              isFloating: true,
              buttonText: "Sign in",
              onPressed: () => OnSigninButtonPressed(),
            )
          ]);
        },
      ),
    );
  }
}
