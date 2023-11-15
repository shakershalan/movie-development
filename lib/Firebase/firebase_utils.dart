import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/model/MoviesList.dart';
import 'package:movies/model/movies.dart';


class FirebaseUtils{
  static CollectionReference<Movie> getMoviesCollection(){
   return FirebaseFirestore.instance.collection("movies").
    withConverter<Movie>(
      fromFirestore:(snapshot, options) =>Movie.fromJson(snapshot.data()!) ,
      toFirestore: (value, options) => value.toJson(),
    );
  }
  static Future<void> addMovieToFireStore(Movie movie){
  var movieCollection = getMoviesCollection();
  DocumentReference<Movie> documentReference = movieCollection.doc() ;
  movie.id = documentReference.id;
 return documentReference.set(movie);

  }
  static Future<void> updateMovieFromJson(Movie movie){
    return getMoviesCollection().doc(movie.id).update({
      "isAdd": !movie.isAdd!
    });

  }
}