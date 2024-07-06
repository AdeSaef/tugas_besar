// booking.dart

class Booking {
  String userName;
  String userEmail;
  String movieTitle;
  String moviePoster; // Tambahkan properti ini

  Booking({
    required this.userName,
    required this.userEmail,
    required this.movieTitle,
    required this.moviePoster, // Tambahkan parameter ini ke konstruktor
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      userName: json['userName'],
      userEmail: json['userEmail'],
      movieTitle: json['movieTitle'],
      moviePoster: json['moviePoster'], // Ambil nilai moviePoster dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'movieTitle': movieTitle,
      'moviePoster': moviePoster, // Simpan nilai moviePoster dalam JSON
    };
  }
}
