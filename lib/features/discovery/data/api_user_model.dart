class ApiUserModel {
  final String name;
  final String email;
  final String image;
  final String location;

  ApiUserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.location,
  });

  factory ApiUserModel.fromJson(Map<String, dynamic> json) {
    return ApiUserModel(
      name: "${json["name"]["first"]} ${json["name"]["last"]}",
      email: json["email"],
      image: json["picture"]["large"],
      location: json["location"]["country"],
    );
  }
}
