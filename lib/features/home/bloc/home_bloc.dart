import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_app/repositories/models/Party.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.inital()) {}
}
