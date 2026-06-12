import 'package:dio/dio.dart';

import 'user_model.dart';

class DiscoveryRemoteDataSource {
  Future<List<UserModel>> getProfiles() async {
    final response = await Dio().get("https://randomuser.me/api/?results=20");

    final List users = response.data["results"];

    return users.map((e) => UserModel.fromJson(e)).toList();
  }
}
