

class Booking {
  String userName;
  String userEmail;
  String movieTitle;
  String moviePoster; 

  Booking({
    required this.userName,
    required this.userEmail,
    required this.movieTitle,
    required this.moviePoster, 
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      userName: json['userName'],
      userEmail: json['userEmail'],
      movieTitle: json['movieTitle'],
      moviePoster: json['moviePoster'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'movieTitle': movieTitle,
      'moviePoster': moviePoster, 
    };
  }
}
