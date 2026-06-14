import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider<String>((ref) => '');

final locationFilterProvider = StateProvider<String>((ref) => 'All');
