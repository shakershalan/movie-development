import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/api/api_constant.dart';
import 'package:movies/model/Genres.dart';

import '../model/MoviesList.dart';
import '../model/MyPopular.dart';
import '../model/my_movie_details.dart';
import '../model/my_recommended.dart';
import '../model/my_search.dart';
import '../model/new_releases.dart';

class ApiManager {
/*
https://api.themoviedb.org/3/movie/popular?api_key=c4c3d1e82f8dee40ffdf440f479d937
*/

  static Future<MyPopular> getPopular() async {
    Uri url = Uri.https(
      ApiConstant.BaseUrl,
      ApiConstant.popularService,
      {'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373'},
    );

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MyPopular.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewReleases> getRelease() async {
    Uri url = Uri.https(
      ApiConstant.BaseUrl,
      ApiConstant.popularService2,
      {'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373'},
    );

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return NewReleases.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MyRecommended> getRecommended() async {
    Uri url = Uri.https(
      ApiConstant.BaseUrl,
      ApiConstant.popularService3,
      {'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373'},
    );

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MyRecommended.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MySearch?> getSearch(String text) async {
    Uri url = Uri.https(
      ApiConstant.BaseUrl,
      ApiConstant.popularService4,
      {'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373', 'query': text},
    );

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MySearch.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<GenresList?> getCategory() async {
    Uri url = Uri.https(ApiConstant.BaseUrl, ApiConstant.genresName,
        {'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373'});

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return GenresList.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesList> getMoviesByGenresId(int genresId) async {
    Uri url = Uri.https(ApiConstant.BaseUrl, ApiConstant.movieList, {

      'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373',
      'with_genres': genresId.toString(),
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MoviesList.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
  static Future<MoviesList> getMovieDetails(int movieId) async {
    Uri url = Uri.https(ApiConstant.BaseUrl, ApiConstant.movieDetails, {

      'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373',
      'movie_id': movieId,
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MoviesList.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MyMovieDetails> myGetMovieDetails(int? movieId) async {
    Uri url = Uri.https(ApiConstant.BaseUrl, '/3/movie/$movieId', {
      'api_key': 'c4c3d1e82f8dee40ffdf440f479d9373',
    });
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return MyMovieDetails.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
