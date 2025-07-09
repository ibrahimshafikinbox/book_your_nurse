import 'package:medical_app/presentation/home/model/service.dart';

class Nurse {
  final String id;
  final String uid;

  final String nameAr;
  final String nameEn;
  final String phone;
  final String photo;
  final String? cityAr;
  final String cityEn;
  final String email;
  List<NurseService>? services;

  Nurse({
    required this.id,
    required this.uid,
    required this.nameAr,
    required this.nameEn,
    required this.phone,
    required this.photo,
    required this.cityAr,
    required this.cityEn,
    required this.email,
    required this.services,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json['services'] as List<dynamic>? ?? [];
    List<NurseService> serviceList = servicesFromJson
        .map((serviceJson) => NurseService.fromJson(serviceJson))
        .toList();

    return Nurse(
      uid: json['uid'] ?? '',
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      phone: json['phone'],
      photo: json['photo'] ??
          "https://cdn.ebaumsworld.com/mediaFiles/picture/718392/86486235.jpg",
      cityAr: json['city_ar'],
      cityEn: json['city_en'],
      email: json['email'] ?? '',
      services: serviceList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "uid": uid,
      'name_ar': nameAr,
      'name_en': nameEn,
      'phone': phone,
      'photo': photo,
      'city_ar': cityAr,
      'city_en': cityEn,
      'email': email,
      'services': services!.map((s) => s.toJson()).toList(),
    };
  }
}
