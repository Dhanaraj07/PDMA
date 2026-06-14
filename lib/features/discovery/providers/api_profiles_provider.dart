import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api_remote_datasource.dart';
import '../data/api_repository.dart';
import '../data/api_user_model.dart';

final apiProfilesProvider = FutureProvider<List<ApiUserModel>>((ref) async {
  final repository = ApiRepository(ApiRemoteDataSource());

  return repository.getProfiles();
});
