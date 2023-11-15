import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/Firebase/firebase_utils.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/model/movies.dart';
import 'package:provider/provider.dart';

import '../providers/list_provider.dart';

class MovieList extends StatelessWidget {
  Movie movie;
 late ListProvider listProvider;

  MovieList(
      {required this.movie});

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
        child: Row(
      children: [
        Stack(children: [
          CachedNetworkImage(
              imageUrl:"https://image.tmdb.org/t/p/w500${movie.image}" ,
              width: MediaQuery.of(context).size.width*.2,
                ),
          Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap:(){
                  updateMovie();
                },
                  child: Image.asset("assets/images/checkmark.png",))
          )
        ]),
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.filmName??"",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: MyTheme.whiteColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                movie.date??"",
                style: TextStyle(
                    fontSize: 13,
                    color: MyTheme.greyColor,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                movie.actor??"",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: MyTheme.greyColor),
              ),
            ],
          ),
        )
      ],
    ));
  }
  void updateMovie() {
    FirebaseUtils.updateMovieFromJson(movie).then((value){
      movie.isAdd = !movie.isAdd!;
      print(movie.isAdd);
      listProvider.getAllMoviesFromJson();
    });
  }

}
