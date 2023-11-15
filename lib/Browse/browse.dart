import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Browse/categorylist.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/api/api_manager.dart';
import 'package:movies/filtered_movies/filtered_movies_view.dart';
import 'package:movies/model/Genres.dart';
import '../bloc/category/genres.dart';


class Browse extends StatefulWidget {
  @override
  State<Browse> createState() => _BrowseState();
}


class _BrowseState extends State<Browse> {
  @override
  void initState() {
    super.initState();
    ApiManager.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Browse Category ",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.whiteColor),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: FutureBuilder<GenresList?>(
                future: ApiManager.getCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.white,));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            'Something went wrong!', style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                ApiManager.getCategory();
                              },
                              child: Text('Try again?'))
                        ],
                      ),
                    );
                  }
                  if (snapshot.data?.success == false) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data?.status_message ?? '', style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                ApiManager.getCategory();
                              },
                              child: Text('Try again?'))
                        ],
                      ),
                    );
                  }
                  var result = snapshot.data?.genres ?? [];
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(onTap: () {
                        BlocProvider.of<GenreCubit>(context).setSelectedGenre(result[index].id!);
                        Navigator.pushNamed(context, FilteredMoviesView.routeName);
                      }, child: CategoryList(genres: result[index]));
                    },
                    itemCount: result.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 25),
                  );
                },
              )
          ),
        ),
      ),
    );
  }
}
