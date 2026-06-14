import 'dart:io';

import 'package:flutter/material.dart';

import '../../profile/data/profile_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final ProfileModel profile;

  const UserDetailsScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: profile.imagePath.isNotEmpty
                  ? FileImage(File(profile.imagePath))
                  : null,
              child: profile.imagePath.isEmpty
                  ? const Icon(Icons.person, size: 70)
                  : null,
            ),

            const SizedBox(height: 20),

            Text(
              profile.fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cake),
                    title: const Text("Age"),
                    subtitle: Text(profile.age),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text("Email"),
                    subtitle: Text(profile.email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("Phone"),
                    subtitle: Text(profile.phone),
                  ),
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text("Occupation"),
                    subtitle: Text(profile.occupation),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Location"),
                    subtitle: Text(profile.location),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Divider(),

                    Text(profile.aboutMe, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
