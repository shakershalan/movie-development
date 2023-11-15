import '../../../model/MyPopular.dart';

abstract class PopularState {}

class PopularLoadingState extends PopularState {}

class PopularErrorState extends PopularState {
  String? errorMessage;

  PopularErrorState({required this.errorMessage});
}

class PopularSuccesState extends PopularState {
  List<Results> result;

  PopularSuccesState({required this.result});
}
