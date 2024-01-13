part of 'home_bloc.dart';

enum HomeStatus { loading, error, none }

class HomeState {
  final List<Party> parties;

  HomeState({required this.parties});

  factory HomeState.inital() {
    return HomeState(parties: []);
  }
}
