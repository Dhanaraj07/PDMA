import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/discovery_provider.dart';
import '../providers/favorites_provider.dart';

class DiscoveryScreen extends ConsumerStatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  ConsumerState<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends ConsumerState<DiscoveryScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(discoveryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Discover Profiles")),
      body: users.when(
        data: (data) {
          final filteredUsers = data.where((user) {
            return user.name.toLowerCase().contains(searchText.toLowerCase());
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search Profiles",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];

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

                        trailing: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            final favorites = ref.read(
                              favoritesProvider.notifier,
                            );

                            favorites.state = [...favorites.state, user.email];

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Added to Favorites"),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },

        error: (e, s) => Center(child: Text(e.toString())),

        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
