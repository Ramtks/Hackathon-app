part of 'authentication_bloc.dart';

enum AuthenticationStatus { loading, error, none }

enum SigninButtonStatus { loading, error, none }

enum SignupButtonStatus { loading, error, none }

class AuthenticationState {
  final String name;
  final InputField<String> email;
  final InputField<String> password;
  final String confirmPassword;
  final SigninButtonStatus signinButtonStatus;
  final SignupButtonStatus signupButtonStatus;
  final AuthenticationStatus authenticationStatus;
  AuthenticationState({
    required this.authenticationStatus,
    required this.signinButtonStatus,
    required this.signupButtonStatus,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(
        email: InputField(
          validate: (value) {
            if (validateEmail(value)) {
              return (isValid: true, message: null);
            } else {
              return (isValid: false, message: 'The email is not valid');
            }
          },
        ),
        password: InputField(
          validate: (value) {
            if (value.length >= 8) {
              return (isValid: true, message: null);
            } else {
              return (isValid: false, message: 'Minimum 8 chars');
            }
          },
        ),
        confirmPassword: '',
        name: '',
        signinButtonStatus: SigninButtonStatus.none,
        signupButtonStatus: SignupButtonStatus.none,
        authenticationStatus: AuthenticationStatus.none);
  }

  AuthenticationState copyWith(
      {String? name,
      String? confirmPassword,
      SigninButtonStatus? signinButtonStatus,
      SignupButtonStatus? signupButtonStatus,
      AuthenticationStatus? authenticationStatus}) {
    return AuthenticationState(
        name: name ?? this.name,
        email: email,
        password: password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        signinButtonStatus: signinButtonStatus ?? this.signinButtonStatus,
        signupButtonStatus: signupButtonStatus ?? this.signupButtonStatus,
        authenticationStatus:
            authenticationStatus ?? this.authenticationStatus);
  }

  bool get isSigninButtonDisabled {
    return !(email.getState == FieldStatus.valid &&
        password.getState == FieldStatus.valid);
  }

  bool get isSignupButtonDisabled {
    return !(email.getState == FieldStatus.valid &&
        password.getState == FieldStatus.valid &&
        password.getValue == confirmPassword &&
        name.isNotEmpty);
  }
}
