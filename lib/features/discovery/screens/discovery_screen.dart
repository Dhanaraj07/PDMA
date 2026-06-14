import 'dart:io';
import 'api_user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/api_favorites_provider.dart';
import '../../profile/providers/profile_provider.dart';
import '../../profile/screens/profile_details_screen.dart';

import '../providers/discovery_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/api_profiles_provider.dart';

class DiscoveryScreen extends ConsumerWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileProvider);

    final search = ref.watch(searchProvider);

    final selectedLocation = ref.watch(locationFilterProvider);

    final apiUsers = ref.watch(apiProfilesProvider);

    final apiLocations = apiUsers.when(
      data: (users) => users.map((e) => e.location).toSet().toList(),
      loading: () => <String>[],
      error: (_, __) => <String>[],
    );

    final locations = [
      'All',
      ...profiles.map((e) => e.location).toSet(),
      ...apiLocations,
    ].toSet().toList();

    final filteredProfiles = profiles.where((profile) {
      final searchMatch = profile.fullName.toLowerCase().contains(
        search.toLowerCase(),
      );

      final locationMatch = selectedLocation == 'All'
          ? true
          : profile.location == selectedLocation;

      return searchMatch && locationMatch;
    }).toList();
    final filteredApiUsers = apiUsers.when(
      data: (users) {
        return users.where((user) {
          final searchMatch = user.name.toLowerCase().contains(
            search.toLowerCase(),
          );

          final locationMatch = selectedLocation == 'All'
              ? true
              : user.location == selectedLocation;

          return searchMatch && locationMatch;
        }).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Discover Profiles"), centerTitle: true),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search Profiles",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref.read(searchProvider.notifier).state = value;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<String>(
                value: selectedLocation,
                decoration: const InputDecoration(
                  labelText: "Filter by Location",
                  border: OutlineInputBorder(),
                ),
                items: locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  ref.read(locationFilterProvider.notifier).state = value!;
                },
              ),
            ),

            const SizedBox(height: 15),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Profiles",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            filteredProfiles.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No Profiles Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = filteredProfiles[index];

                      final favorites = ref.watch(favoritesProvider);

                      final isFavorite = favorites.contains(
                        profiles.indexOf(profile),
                      );

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
                          trailing: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              ref
                                  .read(favoritesProvider.notifier)
                                  .toggleFavorite(profiles.indexOf(profile));
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfileDetailsScreen(
                                  profileIndex: profiles.indexOf(profile),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Suggested Profiles",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            apiUsers.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),

              error: (e, s) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Error : $e"),
              ),

              data: (users) {
                if (filteredApiUsers.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No Suggested Profiles Found"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredApiUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredApiUsers[index];
                    final apiFavorites = ref.watch(apiFavoritesProvider);

                    final isFavorite = apiFavorites.contains(user.email);
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

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onPressed: () {
                                ref
                                    .read(apiFavoritesProvider.notifier)
                                    .toggleFavorite(user.email);
                              },
                            ),

                            const Icon(Icons.arrow_forward_ios, size: 18),
                          ],
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
