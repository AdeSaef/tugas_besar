class Movie {
  String id;
  String title;
  String releaseDate;
  String posterPath;
  String overview; // Tambahkan properti overview

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.overview, // Tambahkan required parameter
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      overview: json['overview'], // Ambil overview dari respons JSON
    );
  }
}

