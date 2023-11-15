import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/bloc/category/state.dart';
import 'package:movies/filtered_movies/filtered_movie_item.dart';

import '../MyTheme.dart';
import '../api/api_manager.dart';
import '../bloc/category/genres.dart';
import '../model/MoviesList.dart';

class FilteredMoviesView extends StatefulWidget {
  static const String routeName = 'filtered_movies';

  @override
  State<FilteredMoviesView> createState() => _FilteredMoviesViewState();
}

class _FilteredMoviesViewState extends State<FilteredMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Browse Category ",
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: MyTheme.whiteColor),
          ),
        ),
      ),
      body: BlocBuilder<GenreCubit, GenreState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: MyTheme.whiteColor,
            ));
          }
          if (state is GenreError) {
            return Center(
              child: Column(
                children: [
                  Text(state.error),
                  ElevatedButton(onPressed: () {}, child: Text('Try Again?'))
                ],
              ),
            );
          }
          if (state is GenreSuccess) {
            return FutureBuilder<MoviesList?>(
              future: ApiManager.getMoviesByGenresId(state.genresId),
              builder: (context, snapshot) {
                var result = snapshot.data?.results ?? [];
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 25),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return FilteredMovieItem(result[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 15.h,
                          child: Divider(
                              color: MyTheme.greyColor,
                              height: 5,
                              thickness: 1),
                        );
                      },
                      itemCount: result.length),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
