import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/Firebase/firebase_utils.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/WatchList/movielist.dart';
import 'package:movies/WatchList/watchlist.dart';
import 'package:movies/model/movies.dart';
import 'package:provider/provider.dart';

import '../model/MoviesList.dart';
import '../model/navigate.dart';
import '../movie_details/movie_details.dart';
import '../providers/list_provider.dart';

class Recommended extends StatefulWidget {
  String image;
  String icon;
  String rating;
  String filmName;
  String date;
  int id;
  bool isAdd = false;
  Recommended(
      {required this.image,
      required this.icon,
      required this.rating,
      required this.filmName,
      required this.date,
      required this.id});

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  bool isAdd = false;

  late Movie movie;

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    movie= Movie(image: widget.image, filmName: widget.filmName, date: widget.date, actor: "");
    listProvider = Provider.of<ListProvider>(context);
    return SingleChildScrollView(
      child: Container(
        color: Color(0xff343534),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(MovieDetails.routeName,
                          arguments: NavigateModel(widget.id));
                    },
                    child:
                        Image.network("https://image.tmdb.org/t/p/w500${widget.image}")),
                InkWell(onTap: () {
                  widget.isAdd = !widget.isAdd;
                  addMovie();
                  listProvider.getAllMoviesFromJson();
                }, child: widget.isAdd == false? Image.asset(widget.icon) : Image.asset("assets/images/checkmark.png")
                )
              ]),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image.asset("assets/images/ratingstar.png"),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  widget.rating,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: MyTheme.whiteColor,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(widget.filmName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: MyTheme.whiteColor)),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.date,
                style: TextStyle(fontSize: 8.sp, color: MyTheme.greyColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addMovie() {
    Movie movie = Movie(
      image: widget.image,
      filmName: widget.filmName,
      date: widget.date,
      actor: "",
    isAdd: widget.isAdd);
    FirebaseUtils.addMovieToFireStore(movie).then(
            (value) {
          print("Done");
          listProvider.getAllMoviesFromJson();
        }
    );
  }

  void updateMovie() {
    FirebaseUtils.updateMovieFromJson(movie).then((value){
      movie.isAdd = !movie.isAdd!;
      print(movie.isAdd);
      listProvider.getAllMoviesFromJson();
    });
  }
}

