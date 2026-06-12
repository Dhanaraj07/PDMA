import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_model.dart';
import '../providers/profile_provider.dart';

class CreateProfileScreen extends ConsumerWidget {
  CreateProfileScreen({super.key});

  final fullNameController = TextEditingController();

  final ageController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final occupationController = TextEditingController();

  final locationController = TextEditingController();

  final aboutController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Age"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),

            TextField(
              controller: occupationController,
              decoration: const InputDecoration(labelText: "Occupation"),
            ),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),

            TextField(
              controller: aboutController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "About Me"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final profile = ProfileModel(
                  fullName: fullNameController.text,
                  age: ageController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  occupation: occupationController.text,
                  location: locationController.text,
                  aboutMe: aboutController.text,
                  imagePath: '',
                );

                ref.read(profileProvider.notifier).state = profile;

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Profile Saved")));
              },
              child: const Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
