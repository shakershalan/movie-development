import '../../../model/my_recommended.dart';

abstract class RecommededState {}

class RecommededLoadingState extends RecommededState {}

class RecommededErrorState extends RecommededState {
  String? errorMessage;

  RecommededErrorState({required this.errorMessage});
}

class RecommededSuccesState extends RecommededState {
  List<Results> result;

  RecommededSuccesState({required this.result});
}
