import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/providers/profile_provider.dart';
import '../../profile/screens/profile_details_screen.dart';

import '../providers/discovery_provider.dart';
import '../providers/favorites_provider.dart';

class DiscoveryScreen extends ConsumerWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileProvider);

    final search = ref.watch(searchProvider);

    final selectedLocation = ref.watch(locationFilterProvider);

    final locations = ['All', ...profiles.map((e) => e.location).toSet()];

    final filteredProfiles = profiles.where((profile) {
      final searchMatch = profile.fullName.toLowerCase().contains(
        search.toLowerCase(),
      );

      final locationMatch = selectedLocation == 'All'
          ? true
          : profile.location == selectedLocation;

      return searchMatch && locationMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Discover Profiles")),

      body: Column(
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
                return DropdownMenuItem(value: location, child: Text(location));
              }).toList(),
              onChanged: (value) {
                ref.read(locationFilterProvider.notifier).state = value!;
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: filteredProfiles.isEmpty
                ? const Center(child: Text("No Profiles Found"))
                : ListView.builder(
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = filteredProfiles[index];

                      final favorites = ref.watch(favoritesProvider);

                      final isFavorite = favorites.contains(index);

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
                                  .toggleFavorite(index);
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
          ),
        ],
      ),
    );
  }
}
