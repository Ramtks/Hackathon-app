part of 'authentication_bloc.dart';

class AuthenticationState {
  final InputField<String> email;
  final InputField<String> password;
  final String confirmPassword;
  AuthenticationState({
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
            if (value.length < 8) {
              return (isValid: true, message: null);
            } else {
              return (isValid: false, message: 'Minimum 8 chars');
            }
          },
        ),
        confirmPassword: '');
  }
}
