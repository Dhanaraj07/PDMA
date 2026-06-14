import 'package:dio/dio.dart';

import 'api_user_model.dart';

class ApiRemoteDataSource {
  Future<List<ApiUserModel>> getProfiles() async {
    final response = await Dio().get("https://randomuser.me/api/?results=10");

    final List users = response.data["results"];

    return users.map((e) => ApiUserModel.fromJson(e)).toList();
  }
}
