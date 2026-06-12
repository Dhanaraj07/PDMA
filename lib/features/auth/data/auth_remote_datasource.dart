import 'dart:async';

class AuthRemoteDataSource {
  Future<String> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "admin@gmail.com" && password == "123456") {
      return "dummy_token_123";
    }

    throw Exception("Invalid Credentials");
  }
}
