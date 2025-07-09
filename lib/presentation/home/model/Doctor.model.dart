
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String about;
  String address;
  String category;
  String city;
  String email;
  String government;
  String name;
  String photo;
  List<double> rating;
  int reservation;
  List<Timestamp> time;

  Doctor({
    required this.about,
    required this.address,
    required this.category,
    required this.city,
    required this.email,
    required this.government,
    required this.name,
    required this.photo,
    required this.rating,
    required this.reservation,
    required this.time,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // Convert the timestamp strings into DateTime objects
    List<dynamic> timeData = json['Time'];
    List<Timestamp> times = timeData
        .map(
            (time) => Timestamp.fromMillisecondsSinceEpoch(time.seconds * 1000))
        .toList();

    // Extracting ratings
    List<dynamic> ratingData = json['Rating'];
    List<double>? ratings =
        ratingData.map((rating) => rating.toDouble()).cast<double>().toList();

    return Doctor(
      about: json['About'],
      address: json['Address'],
      category: json['Category'],
      city: json['City'],
      email: json['Email'],
      government: json['Government'],
      name: json['Name'],
      photo: json['Photo'],
      rating: ratings, // Assigning the extracted ratings
      reservation: json['Reservation'],
      time: times,
    );
  }
  double get averageRating {
    if (rating.isEmpty) {
      return 0.0;
    }
    double totalRating = rating.reduce((value, element) => value + element);
    return totalRating / rating.length;
  }
}
