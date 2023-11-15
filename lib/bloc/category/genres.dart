import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/api/api_manager.dart';
import 'package:movies/bloc/category/state.dart';

class GenreCubit extends Cubit<GenreState> {
   GenreCubit() : super(GenreSuccess(28)); // Default genre ID

  void setSelectedGenre(int genresId) async{
    try{
      emit(GenreLoading());
      var response=await ApiManager.getMoviesByGenresId(genresId);
      if(response.success==false){
        emit(GenreError(response.status_message??'Something went wrong'));
      }
      else{
        emit(GenreSuccess(genresId));
      }
    }catch(e){
      emit(GenreError('Error Loading Filtered Movies'));
    }
  }



  void setError(String error) {
    emit(GenreError(error));
  }
}
