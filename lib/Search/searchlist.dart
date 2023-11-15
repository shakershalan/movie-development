import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/MyTheme.dart';

class SearchList extends StatelessWidget {
  String image;
  String filmName;
  String date;
  String actor;

  SearchList(
      {required this.image,
      required this.filmName,
      required this.date,
      required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 318.w,
        height: MediaQuery.of(context).size.height * .13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500${image}",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            ]),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      filmName,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: MyTheme.whiteColor),
                    ),
                    height: 18.h,
                    width: 250.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    date,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: MyTheme.greyColor,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 50.w,
                    height: 16.h,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      actor,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: MyTheme.greyColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
