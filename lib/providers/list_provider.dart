import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Firebase/firebase_utils.dart';
import '../model/movies.dart';

class ListProvider extends ChangeNotifier{
  List<Movie>movieList = [];

  void getAllMoviesFromJson()async{
  QuerySnapshot<Movie> querySnapshot =await  FirebaseUtils.getMoviesCollection().where("isAdd",isEqualTo: true).get();
  movieList =  querySnapshot.docs.map((doc){
  return  doc.data();
  }).toList();
  notifyListeners();

  }


}