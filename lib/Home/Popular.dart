import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/providers/list_provider.dart';
import 'package:provider/provider.dart';

import '../Firebase/firebase_utils.dart';
import '../MyTheme.dart';
import '../model/movies.dart';
import '../model/navigate.dart';
import '../movie_details/movie_details.dart';

class Popular extends StatefulWidget {
  String? title;
  String? BackDrop;
  String? Poster;
  int? id;
  String? orignalTitle;
  String? overView;

  num? VoteAverage;
  bool? Adult;
  List<int>? Generisid;
  String? orignalLanguage;
  bool? video;
  int? voteCount;
  bool isAdd = false;

  Popular(
      {required this.title,
      required this.id,
      required this.Adult,
      required this.BackDrop,
      required this.Generisid,
      required this.orignalLanguage,
      required this.orignalTitle,
      required this.overView,
      required this.Poster,
      required this.video,
      required this.VoteAverage,
      required this.voteCount});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  late ListProvider listProvider;

  late Movie movie;


  @override
  Widget build(BuildContext context) {
    movie = Movie(image: widget.Poster, filmName: widget.title, date: "", actor: "");
    listProvider = Provider.of<ListProvider>(context);
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(MovieDetails.routeName,
                    arguments: NavigateModel(widget.id));
              },
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${widget.BackDrop}",
                width: double.infinity,
                height: 217.h,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 129.w,
                    height: 199.h,
                    child: Stack(children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                MovieDetails.routeName,
                                arguments: NavigateModel(widget.id));
                          },
                          child: Image.network(
                              "https://image.tmdb.org/t/p/w500${widget.Poster}"),
                        ),
                        height: 199.h,
                        width: 129.w,
                      ),
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
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Padding(
                        padding: EdgeInsets.only(left: 35, bottom: 30),
                        child: Image.asset("assets/images/play-button-2.png"))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .27,
                  left: MediaQuery.of(context).size.width * .35),
              child: Text(
                "${widget.title}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MyTheme.whiteColor, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .31,
                  left: MediaQuery.of(context).size.width * .35),
              child: Text(
                maxLines: 1,
                "2019  PG-13  2h 7m",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MyTheme.greyColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addMovie(){
    Movie movie = Movie(
        image:widget.Poster,
        filmName: widget.title,
        date:"",
        actor:"",
    isAdd: widget.isAdd);
    FirebaseUtils.addMovieToFireStore(movie).then(
            (value){
          print("Done");
          listProvider.getAllMoviesFromJson();
        }
    );
  }

  void updateMovie() {
    Movie movie = Movie(image: widget.Poster, filmName: widget.title, date: "", actor: "");
    FirebaseUtils.updateMovieFromJson(movie).then((value) {
      movie.isAdd = !movie.isAdd!;
      print(movie.isAdd);
      listProvider.getAllMoviesFromJson();
    });
  }
}
