import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/app_routes.dart';
import 'package:hackathon_app/features/authentication/bloc/authentication_bloc.dart';
import 'package:hackathon_app/features/authentication/view/signin_page.dart';
import 'package:hackathon_app/features/authentication/view/signup_page.dart';
import 'package:hackathon_app/features/authentication/view/splash_screen.dart';
import 'package:hackathon_app/features/home/view/home_page.dart';
import 'package:hackathon_app/features/home/view/profile.dart';
import 'package:hackathon_app/features/home/view/party_page.dart';
import 'package:hackathon_app/utils/navigation_service.dart';

final GoRouter router = GoRouter(
  navigatorKey: ContextProvider.navigatorKey,
  debugLogDiagnostics: true,
  // errorBuilder: (context, state) {
  //   return Container();
  // },
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) {
        context.read<AuthenticationBloc>().add(CheckIfSignedin());
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/${AppRoutes.signinPage}',
      name: AppRoutes.signinPage,
      builder: (context, state) {
        return const SigninPage();
      },
    ),
    GoRoute(
      path: '/${AppRoutes.signupPage}',
      name: AppRoutes.signupPage,
      builder: (context, state) {
        return const SignupPage();
      },
    ),
    GoRoute(
      path: '/${AppRoutes.profilePage}',
      name: AppRoutes.profilePage,
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
    GoRoute(
      path: '/${AppRoutes.homePage}',
      name: AppRoutes.homePage,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/${AppRoutes.partyPage}',
      name: AppRoutes.partyPage,
      builder: (context, state) {
        return const PartyPage();
      },
    ),
  ],
);
