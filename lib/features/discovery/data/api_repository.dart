import 'api_remote_datasource.dart';
import 'api_user_model.dart';

class ApiRepository {
  final ApiRemoteDataSource remote;

  ApiRepository(this.remote);

  Future<List<ApiUserModel>> getProfiles() {
    return remote.getProfiles();
  }
}
