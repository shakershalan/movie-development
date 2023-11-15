import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/Home/cubit/popular/popular_view_model.dart';
import 'package:movies/Home/cubit/release/release_view_model.dart';
import 'package:movies/HomeScreen.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/WatchList/watchlist.dart';
import 'package:movies/filtered_movies/filtered_movies_view.dart';
import 'package:movies/providers/list_provider.dart';
import 'package:movies/shared/remote/dio_helper.dart';
import 'package:provider/provider.dart';

import 'bloc/category/genres.dart';
import 'movie_details/movie_details.dart';
import 'observer/myObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<GenreCubit>(
        create: (BuildContext context) => GenreCubit(),
      ),
      BlocProvider<ReleaseViewModel>(
        create: (BuildContext context) => ReleaseViewModel(),
      ),
      BlocProvider<PopularViewModel>(
        create: (BuildContext context) => PopularViewModel(),
      ),
      ChangeNotifierProvider(
          create: (BuildContext context) => ListProvider(),)
    ],
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          MovieDetails.routeName: (context) => MovieDetails(),
          FilteredMoviesView.routeName: (context) => FilteredMoviesView(),
          WatchList.routeName:(context)=>WatchList()
        },
        theme: MyTheme.LightTheme,
      ),
    );
  }
}
