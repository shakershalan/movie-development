import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/HomeScreen.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/model/MoviesList.dart';
import 'package:movies/model/navigate.dart';
import 'package:movies/movie_details/category_tab.dart';
import 'package:provider/provider.dart';
import '../providers/list_provider.dart';
import '../Firebase/firebase_utils.dart';
import '../model/movies.dart';
import 'cubit_Movie/movie_details_view_model.dart';
import 'cubit_Movie/state.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = 'movie_details';
  bool isAdd = false;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var listProvider;
  var cubit;
  var selectedIndex;


  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    var args = ModalRoute.of(context)?.settings.arguments as NavigateModel;
    return BlocProvider(
      create: (context) => MovieDetailsViewModel()
        ..getDetailsData(args.id)
        ..getSimilarData(args.id),
      child: BlocConsumer<MovieDetailsViewModel, MovieDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = MovieDetailsViewModel.get(context);
          return ConditionalBuilder(
            condition: cubit.myMovieDetails != null,
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                title: Text(
                  '${cubit.myMovieDetails?.title}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 412.w,
                                height: 217.h,
                                child: Stack(
                                  children: [
                                    Image.network(
                                      "https://image.tmdb.org/t/p/w500${cubit.myMovieDetails?.backdropPath}",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    Center(
                                        child: Image.asset(
                                            'assets/images/play-button-2.png')),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${cubit.myMovieDetails?.originalTitle}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: MyTheme.whiteColor),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    '${cubit.myMovieDetails?.releaseDate}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: MyTheme.greyColor),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 199.h,
                                        width: 129.w,
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Image.network(
                                                "https://image.tmdb.org/t/p/w500${cubit.myMovieDetails?.posterPath}",
                                                fit: BoxFit.cover,
                                                width: double.infinity),
                                            Image.asset(
                                                'assets/images/bookmark.png')
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CategoryTab(
                                                    "${cubit.myMovieDetails?.genres?[0].name}"),
                                                // CategoryTab("${cubit.myMovieDetails?.genres?[2].name}"),
                                              ],
                                            ),
                                            Container(
                                              width: 231.w,
                                              height: 134.h,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    '${cubit.myMovieDetails?.overview}',
                                                    style: TextStyle(
                                                      color: MyTheme.whiteColor,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    height: 25.h,
                                                    width: 50.w,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: MyTheme
                                                              .yellowColor,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${cubit.myMovieDetails?.voteAverage}',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: MyTheme
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Container(
                        height: 246.h,
                        width: 462.w,
                        color: MyTheme.containerFilmColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "More Like This",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyTheme.whiteColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,

                                    itemBuilder: (context, index) {
                                      selectedIndex = index;
                                      return Container(

                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 184.h,
                                        width: 97.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 96.87.w,
                                              height: 127.74.h,
                                              child: Stack(children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      "https://image.tmdb.org/t/p/w500${cubit.similarModel?.results?[index].posterPath}",
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                    color: MyTheme.whiteColor,
                                                  )),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      widget.isAdd = !widget.isAdd;
                                                      addMovie();
                                                      listProvider.getAllMoviesFromJson();
                                                    },
                                                    child: widget.isAdd == true ? Image.asset("assets/images/checkmark.png"):
                                                    Image.asset(
                                                        'assets/images/bookmark.png'))
                                              ]),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 3),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          "assets/images/ratingstar.png"),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${cubit.similarModel?.results?[index].voteAverage}",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: MyTheme
                                                                .whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${cubit.similarModel?.results?[index].title}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: MyTheme
                                                              .whiteColor)),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                   "${cubit.similarModel?.results?[index].releaseDate}",
                                                    style: TextStyle(
                                                        fontSize: 8,
                                                        color:
                                                            MyTheme.greyColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount:
                                        cubit.similarModel?.results?.length),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          );
        },
      ),
    );
  }

  void addMovie() {
    Movie movie = Movie(
        image:  "https://image.tmdb.org/t/p/w500${cubit.similarModel?.results?[selectedIndex].posterPath}" ,
        filmName:  "${cubit.similarModel?.results?[selectedIndex].title}",
        date:  "${cubit.similarModel?.results?[selectedIndex].releaseDate}",
        actor: "",
        isAdd: widget.isAdd
    );
    FirebaseUtils.addMovieToFireStore(movie).then((value) {
      print("Done");
      listProvider.getAllMoviesFromJson();
    });
  }
  void updateMovie() {
    Movie movie = Movie(image:  "https://image.tmdb.org/t/p/w500${cubit.similarModel?.results?[selectedIndex].posterPath}" ,
        filmName:  "${cubit.similarModel?.results?[selectedIndex].title}",
        date:  "${cubit.similarModel?.results?[selectedIndex].releaseDate}",
        actor: "",
        isAdd: widget.isAdd);
    FirebaseUtils.updateMovieFromJson(movie).then((value){

      movie.isAdd = !movie.isAdd!;
      print(movie.isAdd);
      listProvider.getAllMoviesFromJson();
    });
  }

}
