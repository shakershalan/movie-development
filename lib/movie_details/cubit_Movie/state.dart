abstract class MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  String? errorMessage;

  MovieDetailsErrorState({required this.errorMessage});
}

class MovieDetailsSuccesState extends MovieDetailsState {}

class SimilarStateLoadingState extends MovieDetailsState {}

class SimilarStateErrorState extends MovieDetailsState {
  String? errorMessage;

  SimilarStateErrorState({required this.errorMessage});
}

class SimilarStateSuccesState extends MovieDetailsState {}
