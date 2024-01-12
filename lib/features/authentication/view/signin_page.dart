import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/app_routes.dart';
import 'package:hackathon_app/features/components/action_button.dart';
import 'package:hackathon_app/features/components/custom_form_text_field.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  hintText: "Email",
                  showError: false,
                  onChange: (value) {}),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  borderRadius: 25,
                  hintText: "Password",
                  showError: false,
                  onChange: (value) {}),
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
                    onPressed: () => context.pushReplacementNamed(AppRoutes.signupPage),
                  )
                ],
              )
            ],
          ),
        ),
        ActionButton(
          isFloating: true,
          buttonText: "Sign in",
          onPressed: () {},
        )
      ]),
    );
  }
}
