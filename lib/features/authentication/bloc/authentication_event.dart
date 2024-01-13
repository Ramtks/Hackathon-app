part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class OnSigninButtonPressed extends AuthenticationEvent {}

class OnSignUpButtonPressed extends AuthenticationEvent {}

class EmailChanged extends AuthenticationEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends AuthenticationEvent {
  final String password;

  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends AuthenticationEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);
}

class NameChanged extends AuthenticationEvent {
  final String name;

  NameChanged(this.name);
}

class CheckIfSignedin extends AuthenticationEvent {}

class LogoutButtonPressed extends AuthenticationEvent {}
