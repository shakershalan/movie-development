import 'package:flutter/material.dart';
import 'package:movies/Browse/browse.dart';
import 'package:movies/Home/home.dart';
import 'package:movies/MyTheme.dart';
import 'package:movies/Search/search.dart';
import 'package:movies/WatchList/watchlist.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: MyTheme.bottomColor),
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (newindex) {
              selectedIndex = newindex;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "SEARCH"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.call_to_action), label: "MOVIE"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: "WATCHLIST"),
            ]),
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [Home(), Search(), Browse(), WatchList()];
}
