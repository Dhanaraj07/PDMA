import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_details_screen.dart';
import '../../profile/providers/profile_provider.dart';
import '../../profile/screens/profile_details_screen.dart';
import '../providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileProvider);

    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Profiles")),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Profiles Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final profileIndex = favorites[index];

                if (profileIndex >= profiles.length) {
                  return const SizedBox();
                }

                final profile = profiles[profileIndex];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: profile.imagePath.isNotEmpty
                          ? FileImage(File(profile.imagePath))
                          : null,
                      child: profile.imagePath.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    ),

                    title: Text(profile.fullName),

                    subtitle: Text(profile.location),

                    trailing: const Icon(Icons.favorite, color: Colors.red),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailsScreen(profile: profile),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
