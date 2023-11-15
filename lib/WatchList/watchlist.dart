import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/Firebase/firebase_utils.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/providers/list_provider.dart';
import 'package:provider/provider.dart';

import '../model/MoviesList.dart';
import '../model/movies.dart';
import 'movielist.dart';

class WatchList extends StatelessWidget {
  static const String routeName = "List";



  @override
  Widget build(BuildContext context) {
   var listProvider =Provider.of<ListProvider>(context);
    if(listProvider.movieList.isEmpty){
     listProvider.getAllMoviesFromJson();
    }

    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Watchlist",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.whiteColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * .65,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return MovieList(movie:listProvider.movieList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15.h,
                        child: Divider(
                            color: MyTheme.greyColor, height: 3, thickness: 1),
                      );
                    },
                    itemCount: listProvider.movieList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
