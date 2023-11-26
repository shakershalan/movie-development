import 'package:flutter/material.dart';
import 'package:movies/Firebase/firebase_utils.dart';
import 'package:movies/WatchList/watchlist.dart';
import 'package:movies/model/navigate.dart';
import 'package:movies/movie_details/movie_details.dart';
import 'package:provider/provider.dart';

import '../model/MoviesList.dart';
import '../model/movies.dart';
import '../providers/list_provider.dart';

class NewRelease extends StatefulWidget {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;

  NewRelease(
      this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  int? voteCount;
  bool isAdd = false;
  @override
  State<NewRelease> createState() => _NewReleaseState();
}

class _NewReleaseState extends State<NewRelease> {
  late ListProvider listProvider;

  late Movie movie;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);

    movie = Movie(
      image: widget.posterPath,
      filmName: widget.title,
      date: widget.releaseDate,
      actor: "",
    );
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Stack(children: [
        InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(MovieDetails.routeName,
                  arguments: NavigateModel(widget.id));
            },
            child: Image.network(
                "https://image.tmdb.org/t/p/w500${widget.posterPath}")),
        InkWell(
            onTap: () {
              widget.isAdd = !widget.isAdd;
              addMovie();
              listProvider.getAllMoviesFromJson();
            },
            child: widget.isAdd == false
                ? Image.asset("assets/images/bookmark.png")
                : Image.asset("assets/images/checkmark.png"))
      ]),
    );
  }

  void addMovie() {
    Movie movie = Movie(
        image: widget.posterPath,
        filmName: widget.title,
        date: widget.releaseDate,
        actor: "",
        isAdd: true);
    FirebaseUtils.addMovieToFireStore(movie).then((value) {
      print("Done");
      print(movie.isAdd);
      listProvider.getAllMoviesFromJson();
    });
  }

  void updateMovie() {
    FirebaseUtils.updateMovieFromJson(movie).then((value) {
      movie.isAdd = !movie.isAdd!;
      listProvider.getAllMoviesFromJson();
    });
  }
}

//"assets/images/filmposter.png"
//"assets/images/bookmark.png"
