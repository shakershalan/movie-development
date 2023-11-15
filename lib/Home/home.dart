import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/Home/NewRelease.dart';
import 'package:movies/Home/Popular.dart';
import 'package:movies/Home/Recommended.dart';
import 'package:movies/Home/cubit/popular/popular_view_model.dart';
import 'package:movies/Home/cubit/popular/state.dart';
import 'package:movies/Home/cubit/recommended/recommended_view_model.dart';
import 'package:movies/Home/cubit/recommended/state.dart';
import 'package:movies/Home/cubit/release/release_view_model.dart';
import 'package:movies/Home/cubit/release/state.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/api/api_manager.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ReleaseViewModel viewModel = ReleaseViewModel();
  PopularViewModel viewModel2 = PopularViewModel();
  RecommendedViewModel viewModel3 = RecommendedViewModel();

  @override
  void initState() {
    // TODO: implement initState

    viewModel.getReleases();
    viewModel2.getPopular();
    viewModel3.getRecommended();
  }

  @override
  Widget build(BuildContext context) {
    ApiManager.getPopular();
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<PopularViewModel, PopularState>(
            bloc: viewModel2,
            builder: (context, state) {
              if (state is PopularLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: MyTheme.whiteColor),
                );
              } else if (state is PopularErrorState) {
                return Column(
                  children: [
                    Text(state.errorMessage ?? ""),
                    ElevatedButton(onPressed: () {}, child: Text("Try again"))
                  ],
                );
              } else if (state is PopularSuccesState) {
                return CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: false,
                      height: 390.h,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      enableInfiniteScroll: true,
                    ),
                    itemCount: state.result.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Popular(
                          title: state.result[itemIndex].title,
                          id: state.result[itemIndex].id,
                          Adult: state.result[itemIndex].adult,
                          BackDrop: state.result[itemIndex].backdropPath,
                          Generisid: state.result[itemIndex].genreIds,
                          orignalLanguage:
                              state.result[itemIndex].originalLanguage,
                          orignalTitle: state.result[itemIndex].originalTitle,
                          overView: state.result[itemIndex].overview,
                          Poster: state.result[itemIndex].posterPath,
                          video: state.result[itemIndex].video,
                          VoteAverage: state.result[itemIndex].voteAverage,
                          voteCount: state.result[itemIndex].voteCount);
                    });
              }
              return Container();
            },
          ),
          BlocBuilder<ReleaseViewModel, HomeState>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: MyTheme.whiteColor),
                );
              } else if (state is HomeErrorState) {
                return Column(
                  children: [
                    Text(state.errorMessage ?? ""),
                    ElevatedButton(onPressed: () {}, child: Text("Try again"))
                  ],
                );
              } else if (state is ReleaseSuccesState) {
                return Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .18,
                    width: double.infinity,
                    color: MyTheme.containerFilmColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "New Releases ",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: MyTheme.whiteColor),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .03,
                                );
                              },
                              itemBuilder: (context, index) {
                                return NewRelease(
                                    state.result[index].adult,
                                    state.result[index].backdropPath,
                                    state.result[index].genreIds,
                                    state.result[index].id,
                                    state.result[index].originalLanguage,
                                    state.result[index].originalTitle,
                                    state.result[index].overview,
                                    state.result[index].popularity,
                                    state.result[index].posterPath,
                                    state.result[index].releaseDate,
                                    state.result[index].title,
                                    state.result[index].video,
                                    state.result[index].voteAverage,
                                    state.result[index].voteCount);
                              },
                              itemCount: state.result.length,
                              scrollDirection: Axis.horizontal),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          BlocBuilder<RecommendedViewModel, RecommededState>(
            bloc: viewModel3,
            builder: (context, state) {
              if (state is RecommededLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: MyTheme.whiteColor),
                );
              } else if (state is RecommededErrorState) {
                return Column(
                  children: [
                    Text(state.errorMessage ?? ""),
                    ElevatedButton(onPressed: () {}, child: Text("Try again"))
                  ],
                );
              } else if (state is RecommededSuccesState) {
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: double.infinity,
                    color: MyTheme.containerFilmColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Recomended",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: MyTheme.whiteColor),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                    height: 127.74.h,
                                    width: 96.87.w,
                                    child: Recommended(
                                        id: state.result[index].id ?? 0,
                                        image: state.result[index].posterPath ??
                                            "",
                                        icon: "assets/images/bookmark.png",
                                        rating:
                                            "${state.result[index].voteAverage}",
                                        filmName:
                                            "${state.result[index].title}",
                                        date:
                                            "${state.result[index].releaseDate}"));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .02,
                                );
                              },
                              itemCount: state.result.length),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
