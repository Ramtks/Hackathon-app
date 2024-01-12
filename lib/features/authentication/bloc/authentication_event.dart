part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class OnSigninButtonPressed extends AuthenticationEvent {}
class OnSignUpButtonPressed extends AuthenticationEvent {}

