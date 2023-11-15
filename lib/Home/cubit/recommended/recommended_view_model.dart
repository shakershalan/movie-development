import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Home/cubit/recommended/state.dart';

import '../../../api/api_manager.dart';

class RecommendedViewModel extends Cubit<RecommededState> {
  RecommendedViewModel() : super(RecommededLoadingState());

  void getRecommended() async {
    try {
      emit(RecommededLoadingState());
      var response = await ApiManager.getRecommended();
      if (response?.success == false) {
        emit(RecommededErrorState(errorMessage: response?.status_message));
      } else {
        emit(RecommededSuccesState(result: response.results!));
      }
    } catch (e) {
      emit(RecommededLoadingState());
    }
  }
}
