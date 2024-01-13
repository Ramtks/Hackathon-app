import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/app_routes.dart';
import 'package:hackathon_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:hackathon_app/features/components/action_button.dart';
import 'package:hackathon_app/features/components/custom_form_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                      borderRadius: 25,
                      hintText: "Name",
                      initialText: state.name,
                      showError: false,
                      onChange: (value) {
                        context
                            .read<AuthenticationBloc>()
                            .add(NameChanged(value));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      borderRadius: 25,
                      hintText: "Email",
                      initialText: state.email.getValue,
                      showError: !state.email.getIsValid,
                      errorText: state.email.getErrorMessage ?? '',
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
                      initialText: state.password.getValue,
                      hintText: "Password",
                      showError: !state.password.getIsValid,
                      errorText: state.password.getErrorMessage ?? '',
                      onChange: (value) {
                        context
                            .read<AuthenticationBloc>()
                            .add(PasswordChanged(value));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      isObsecure: true,
                      borderRadius: 25,
                      initialText: state.confirmPassword,
                      hintText: "Confirm password",
                      showError: state.confirmPassword !=
                          (state.password.getValue ?? ''),
                      errorText: 'Not identical',
                      onChange: (value) {
                        context
                            .read<AuthenticationBloc>()
                            .add(ConfirmPasswordChanged(value));
                      }),
                  Row(
                    children: [
                      TextButton(
                        child: Text(
                          'Signin instead?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                        onPressed: () =>
                            context.pushReplacementNamed(AppRoutes.signinPage),
                      )
                    ],
                  )
                ],
              ),
            ),
            ActionButton(
              isLoading: state.signupButtonStatus == SignupButtonStatus.loading,
              isDisabled: state.isSignupButtonDisabled,
              isFloating: true,
              buttonText: "Sign up",
              onPressed: () => context
                  .read<AuthenticationBloc>()
                  .add(OnSignUpButtonPressed()),
            )
          ]);
        },
      ),
    );
  }
}
