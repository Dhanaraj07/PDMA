import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:profile_discovery_app/features/auth/screens/splash_screen.dart';
import 'package:profile_discovery_app/features/settings/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('favorites');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Profile Discovery App',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0D47A1),
      ),

      darkTheme: ThemeData.dark(useMaterial3: true),

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: const SplashScreen(),
    );
  }
}
