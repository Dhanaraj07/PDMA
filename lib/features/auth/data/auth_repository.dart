import 'auth_remote_datasource.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository(this.remoteDataSource);

  Future<String> login(String email, String password) async {
    return await remoteDataSource.login(email: email, password: password);
  }
}
