import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/Search/searchlist.dart';
import 'package:movies/api/api_manager.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var textSearch = TextEditingController();

  List<SearchList> searchList = [
    SearchList(
        image: "assets/images/favmovie.png",
        filmName: "Alita Battle Angel",
        date: "2019",
        actor: "Rosa Salazar, Christoph Waltz"),
    SearchList(
        image: "assets/images/favmovie.png",
        filmName: "Alita Battle Angel",
        date: "2019",
        actor: "Rosa Salazar, Christoph Waltz"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextFormField(
                style: TextStyle(
                    color: MyTheme.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
                controller: textSearch,
                onFieldSubmitted: (text) {
                  ApiManager.getSearch(textSearch.text);

                  setState(() {});
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.w, color: MyTheme.greyColor),
                      borderRadius: BorderRadius.circular(30.0.r),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.w, color: MyTheme.greyColor),
                      borderRadius: BorderRadius.circular(30.0.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.w, color: MyTheme.greyColor),
                      borderRadius: BorderRadius.circular(30.0.r),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.w, color: MyTheme.yellowColor),
                      borderRadius: BorderRadius.circular(30.0.r),
                    ),
                    filled: true,
                    fillColor: MyTheme.darkGreyColor,
                    prefixIcon: InkWell(
                        onTap: () {
                          search();
                          setState(() {});
                        },
                        child: Icon(Icons.search)),
                    prefixIconColor: MyTheme.whiteColor,
                    hintText: "search",
                    hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: MyTheme.greyColor)),
              ),
            ),
            FutureBuilder(
              future: ApiManager.getSearch(textSearch.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: MyTheme.whiteColor),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text("someThing went wrong"),
                      ElevatedButton(onPressed: () {}, child: Text("Try again"))
                    ],
                  );
                }
                if (snapshot.data?.success == false) {
                  return Column(
                    children: [
                      Text(snapshot.data?.status_message ?? ""),
                      ElevatedButton(onPressed: () {}, child: Text("Try again"))
                    ],
                  );
                }
                var searchlist = snapshot.data?.results ?? [];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * .65,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SearchList(
                              image: searchlist[index].posterPath ?? "",
                              filmName: searchlist[index].title ?? "",
                              date: searchlist[index].releaseDate ?? "",
                              actor: searchlist[index].originalTitle ?? "");
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15.h,
                            child: Divider(
                                color: MyTheme.greyColor,
                                height: 3.h,
                                thickness: 1),
                          );
                        },
                        itemCount: searchlist.length),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void search() {
    ApiManager.getSearch(textSearch.text);
  }
}
