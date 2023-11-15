import 'package:flutter/material.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/filtered_movies/filtered_movies_view.dart';
import '../model/Genres.dart';

class CategoryList extends StatelessWidget {
  Genres genres;
  CategoryList({required this.genres});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/category.png",
          fit: BoxFit.fill,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .15,
        ),
        Text(
        genres.name??'',
          style: TextStyle(
              fontSize: 15,
              color: MyTheme.whiteColor,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
