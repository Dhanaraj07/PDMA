import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/providers/profile_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/api_favorites_provider.dart';
import '../providers/api_profiles_provider.dart';

import 'user_details_screen.dart';
import 'api_user_details_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileProvider);

    final favorites = ref.watch(favoritesProvider);

    final apiFavorites = ref.watch(apiFavoritesProvider);

    final apiUsers = ref.watch(apiProfilesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Profiles"), centerTitle: true),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// LOCAL FAVORITES
            if (favorites.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Favorite Profiles",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final profileIndex = favorites[index];

                  if (profileIndex >= profiles.length) {
                    return const SizedBox();
                  }

                  final profile = profiles[profileIndex];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
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
            ],

            /// API FAVORITES
            apiUsers.when(
              loading: () => const SizedBox(),

              error: (_, __) => const SizedBox(),

              data: (users) {
                final favoriteApiUsers = users
                    .where((user) => apiFavorites.contains(user.email))
                    .toList();

                if (favoriteApiUsers.isEmpty) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Suggested Favorites",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favoriteApiUsers.length,
                      itemBuilder: (context, index) {
                        final user = favoriteApiUsers[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.image),
                            ),

                            title: Text(user.name),

                            subtitle: Text(user.location),

                            trailing: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ApiUserDetailsScreen(
                                    name: user.name,
                                    email: user.email,
                                    image: user.image,
                                    location: user.location,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            if (favorites.isEmpty && apiFavorites.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    "No Favorite Profiles Yet",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
