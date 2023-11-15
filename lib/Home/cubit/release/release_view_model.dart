import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Home/cubit/release/state.dart';
import 'package:movies/api/api_manager.dart';

class ReleaseViewModel extends Cubit<HomeState> {
  ReleaseViewModel() : super(HomeLoadingState());

  void getReleases() async {
    try {
      emit(HomeLoadingState());
      var response = await ApiManager.getRelease();
      if (response?.success == false) {
        emit(HomeErrorState(errorMessage: response?.status_message));
      } else {
        emit(ReleaseSuccesState(result: response.results!));
      }
    } catch (e) {
      emit(HomeLoadingState());
    }
  }
}
