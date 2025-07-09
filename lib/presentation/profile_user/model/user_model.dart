class UserModel {
  final String id;
  final String phoneNumber;
  final String about;
  final String email;
  final String image;
  final String name;
  final String phone;
  final String userType;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.about,
    required this.email,
    required this.image,
    required this.name,
    required this.phone,
    required this.userType,
  });

  // تحويل JSON إلى كائن Dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      about: json['about'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      userType: json['userType'] ?? '',
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PhoneNumber': phoneNumber,
      'about': about,
      'email': email,
      'image': image,
      'name': name,
      'phone': phone,
      'userType': userType,
    };
  }
}
