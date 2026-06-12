class UserModel {
  final String name;
  final String email;
  final String image;
  final String location;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: "${json["name"]["first"]} ${json["name"]["last"]}",
      email: json["email"],
      image: json["picture"]["large"],
      location: json["location"]["country"],
    );
  }
}
