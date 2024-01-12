import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/utils/input_field.dart';
import 'package:hackathon_app/utils/validation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.initial()) {
    on<AuthenticationEvent>((event, emit) {
    });
  }
}
