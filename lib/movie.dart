class Movie {
  String id;
  String title;
  String releaseDate;
  String posterPath;
  String overview; 

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.overview, 
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: 'https:
      overview: json['overview'], 
    );
  }
}

