import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/discovery_remote_datasource.dart';
import '../data/discovery_repository.dart';
import '../data/user_model.dart';

final discoveryProvider = FutureProvider<List<UserModel>>((ref) async {
  final repository = DiscoveryRepository(DiscoveryRemoteDataSource());

  final users = await repository.getProfiles();

  return users;
});
