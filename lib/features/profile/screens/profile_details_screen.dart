import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edit_profile_screen.dart';
import '../providers/profile_provider.dart';

class ProfileDetailsScreen extends ConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    if (profile == null) {
      return const Scaffold(body: Center(child: Text("No Profile Found")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name : ${profile.fullName}"),

            const SizedBox(height: 10),

            Text("Age : ${profile.age}"),

            const SizedBox(height: 10),

            Text("Email : ${profile.email}"),

            const SizedBox(height: 10),

            Text("Phone : ${profile.phone}"),

            const SizedBox(height: 10),

            Text("Occupation : ${profile.occupation}"),

            const SizedBox(height: 10),

            Text("Location : ${profile.location}"),

            const SizedBox(height: 10),

            Text("About : ${profile.aboutMe}"),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
