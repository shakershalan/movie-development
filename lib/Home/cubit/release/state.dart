import '../../../model/new_releases.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  String? errorMessage;

  HomeErrorState({required this.errorMessage});
}

class ReleaseSuccesState extends HomeState {
  List<Results> result;

  ReleaseSuccesState({required this.result});
}
