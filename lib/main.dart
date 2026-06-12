import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile_discovery_app/features/discovery/screens/discovery_screen.dart';
import 'package:profile_discovery_app/features/discovery/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('favorites');

  runApp(const ProviderScope(child: MyApp()));
}
