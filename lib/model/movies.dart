class Movie {
  String? image;
  String? filmName;
  String? date;
  String? actor;
  String? id;
  bool? isAdd;

  Movie(
      {this.id = "",
      required this.image,
      required this.filmName,
      required this.date,
      required this.actor,
      this.isAdd= false});
  Movie.fromJson(Map<String, dynamic> jason)
      : this(
            id: jason["id"],
            filmName: jason["filmName"],
            image: jason["image"],
            date: jason["date"],
            actor: jason["actor"],
            isAdd: jason["isAdd"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "filmName": filmName,
      "date": date,
      "actor": actor,
      "isAdd": isAdd
    };
  }
}
/*
 "voteCount": voteCount,
      "voteAverage": voteAverage,
      "posterPath": posterPath,
      "popularity": "popularity",
      "overview": overview,
      "originalTitle": originalTitle,
      "originalLanguage": originalLanguage,
      "genreIds":  genreIds,
      "backdropPath": backdropPath,
      "adult":  adult,
      "title": title,
      "video": video,
      "releaseDate": releaseDate,
      "Adult": j"Adult"],
      BackDrop: jason["BackDrop"],
      Generisid: jason["Generisid"],
      orignalLanguage: jason[" orignalLanguage"],
      orignalTitle: jason[" orignalTitle"],
      overView: jason[" overView"],
      Poster: jason[" Poster"],
      VoteAverage: jason["  VoteAverage"

           voteCount: jason["voteCount"],
            voteAverage: jason["voteAverage"],
            posterPath: jason["posterPath"],
            popularity: jason["popularity"],
            overview: jason["overview"],
            originalTitle: jason["originalTitle"],
            originalLanguage: jason["originalLanguage"],
            genreIds: jason[" genreIds"],
            backdropPath: jason["backdropPath"],
            adult: jason[" adult"],
            title: jason["title"],
            video: jason[" video"],
            releaseDate: jason["releaseDate"],
            Adult: jason["Adult"],
            BackDrop: jason["BackDrop"],
            Generisid: jason["Generisid"],
            orignalLanguage: jason[" orignalLanguage"],
            orignalTitle: jason[" orignalTitle"],
            overView: jason[" overView"],
            Poster: jason[" Poster"],
            VoteAverage: jason["  VoteAverage"


             required this.voteCount,
    required this.voteAverage,
    required this.posterPath,
    required this.popularity,
    required this.overview,
    required this.originalTitle,
    required this.originalLanguage,
    required this.genreIds,
    required this.backdropPath,
    required this.adult,
    required this.title,
    required this.video,
    required this.releaseDate,
    required this.Adult,
    required this.BackDrop,
    required this.Generisid,
    required this.orignalLanguage,
    required this.orignalTitle,
    required this.overView,
    required this.Poster,
    required this.VoteAverage,

    String? title;
  String? BackDrop;
  String? Poster;
  String? orignalTitle;
  String? overView;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? originalLanguage;
  String? originalTitle;
  num? VoteAverage;
  bool? Adult;
  List<int>? Generisid;
  String? orignalLanguage;
  bool? video;
  int? voteCount;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  double? voteAverage;

 */
