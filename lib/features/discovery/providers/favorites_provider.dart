import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorites_provider.dart';

final favoritesProvider = StateProvider<List<String>>((ref) => []);
