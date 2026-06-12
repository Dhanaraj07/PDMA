import 'user_model.dart';
import 'discovery_remote_datasource.dart';

class DiscoveryRepository {
  final DiscoveryRemoteDataSource remoteDataSource;

  DiscoveryRepository(this.remoteDataSource);

  Future<List<UserModel>> getProfiles() async {
    return await remoteDataSource.getProfiles();
  }
}
