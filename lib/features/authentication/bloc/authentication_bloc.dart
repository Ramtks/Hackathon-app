import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/app_routes.dart';
import 'package:hackathon_app/repositories/authentication_repository.dart';
import 'package:hackathon_app/utils/input_field.dart';
import 'package:hackathon_app/utils/navigation_service.dart';
import 'package:hackathon_app/utils/validation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final ContextProvider contextProvider;

  AuthenticationBloc(
      {required this.authRepository, required this.contextProvider})
      : super(AuthenticationState.initial()) {
    on<EmailChanged>((event, emit) {
      state.email.setValueWithValidation(event.email);
      emit(state.copyWith());
    });
    on<PasswordChanged>((event, emit) {
      state.password.setValueWithValidation(event.password);
      emit(state.copyWith());
    });
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<OnSignUpButtonPressed>((event, emit) async {
      if (state.signupButtonStatus == SignupButtonStatus.loading) {
        return;
      }
      state.copyWith(signupButtonStatus: SignupButtonStatus.loading);
      final result = await authRepository.signUp(
          state.email.getValue!, state.name, state.password.getValue!);
      result.fold((l) {
        emit(state.copyWith(signupButtonStatus: SignupButtonStatus.none));
        contextProvider.pushReplacementNamed(AppRoutes.homePage);
      }, (r) {
        emit(state.copyWith(signupButtonStatus: SignupButtonStatus.error));
      });
    });

    on<OnSigninButtonPressed>((event, emit) async {
      if (state.signinButtonStatus == SigninButtonStatus.loading) {
        return;
      }
      state.copyWith(signinButtonStatus: SigninButtonStatus.loading);
      final result = await authRepository.signIn(
          state.email.getValue!, state.password.getValue!);
      result.fold((l) {
        emit(state.copyWith(signinButtonStatus: SigninButtonStatus.none));
        contextProvider.pushReplacementNamed(AppRoutes.homePage);
      }, (r) {
        emit(state.copyWith(signinButtonStatus: SigninButtonStatus.error));
      });
    });

    on<CheckIfSignedin>((event, emit) async {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
      final result = await authRepository.checkIfSignedIn();
      result.fold((l) {
        if (l) {
          contextProvider.pushReplacementNamed(AppRoutes.homePage);
          emit(state.copyWith(authenticationStatus: AuthenticationStatus.none));
        } else {
          contextProvider.pushReplacementNamed(AppRoutes.signinPage);
          emit(state.copyWith(authenticationStatus: AuthenticationStatus.none));
        }
      }, (r) {
        emit(state.copyWith(authenticationStatus: AuthenticationStatus.error));
      });
    });
    on<LogoutButtonPressed>((event, emit) async {
      final result = await authRepository.logOut();
      result.fold(
          (l) => contextProvider.pushReplacementNamed(AppRoutes.signinPage),
          (r) {});
    });
  }
}
