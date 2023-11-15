import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Home/cubit/popular/state.dart';

import '../../../api/api_manager.dart';

class PopularViewModel extends Cubit<PopularState> {
  PopularViewModel() : super(PopularLoadingState());

  void getPopular() async {
    try {
      emit(PopularLoadingState());
      var response = await ApiManager.getPopular();
      if (response?.success == false) {
        emit(PopularErrorState(errorMessage: response?.status_message));
      } else {
        emit(PopularSuccesState(result: response.results!));
      }
    } catch (e) {
      emit(PopularLoadingState());
    }
  }
}
