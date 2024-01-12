import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:hackathon_app/utils/app_themes.dart';
import 'package:hackathon_app/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppThemes.darkTheme,
      ),
    );
  }
}
