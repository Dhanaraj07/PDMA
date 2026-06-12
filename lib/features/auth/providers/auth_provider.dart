import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_remote_datasource.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(AuthRemoteDataSource());
});

final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) {
  return LoginNotifier(ref.read(authRepositoryProvider));
});

class LoginNotifier extends StateNotifier<bool> {
  final AuthRepository repository;

  LoginNotifier(this.repository) : super(false);

  Future<String?> login(String email, String password) async {
    try {
      state = true;

      final token = await repository.login(email, password);

      state = false;

      return token;
    } catch (e) {
      print("LOGIN ERROR => $e");

      state = false;
      return null;
    }
  }
}
