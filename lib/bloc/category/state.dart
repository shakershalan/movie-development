abstract class GenreState {}

class GenreLoading extends GenreState {}

class GenreSuccess extends GenreState {
  final int genresId;
  GenreSuccess(this.genresId);
}

class GenreError extends GenreState {
  final String error;
  GenreError(this.error);
}
