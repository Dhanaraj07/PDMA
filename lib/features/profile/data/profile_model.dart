import 'dart:convert';

class ProfileModel {
  final String fullName;
  final String age;
  final String email;
  final String phone;
  final String occupation;
  final String location;
  final String aboutMe;
  final String imagePath;

  ProfileModel({
    required this.fullName,
    required this.age,
    required this.email,
    required this.phone,
    required this.occupation,
    required this.location,
    required this.aboutMe,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'age': age,
      'email': email,
      'phone': phone,
      'occupation': occupation,
      'location': location,
      'aboutMe': aboutMe,
      'imagePath': imagePath,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      fullName: map['fullName'] ?? '',
      age: map['age'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      occupation: map['occupation'] ?? '',
      location: map['location'] ?? '',
      aboutMe: map['aboutMe'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ProfileModel.fromJson(String source) {
    return ProfileModel.fromMap(jsonDecode(source));
  }
}
