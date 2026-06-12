import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_model.dart';
import '../providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController fullName;
  late TextEditingController age;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController occupation;
  late TextEditingController location;
  late TextEditingController about;

  @override
  void initState() {
    super.initState();

    final profile = ref.read(profileProvider);

    fullName = TextEditingController(text: profile?.fullName ?? '');

    age = TextEditingController(text: profile?.age ?? '');

    email = TextEditingController(text: profile?.email ?? '');

    phone = TextEditingController(text: profile?.phone ?? '');

    occupation = TextEditingController(text: profile?.occupation ?? '');

    location = TextEditingController(text: profile?.location ?? '');

    about = TextEditingController(text: profile?.aboutMe ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: fullName,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),

            TextField(
              controller: age,
              decoration: const InputDecoration(labelText: "Age"),
            ),

            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            TextField(
              controller: occupation,
              decoration: const InputDecoration(labelText: "Occupation"),
            ),

            TextField(
              controller: location,
              decoration: const InputDecoration(labelText: "Location"),
            ),

            TextField(
              controller: about,
              decoration: const InputDecoration(labelText: "About Me"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                ref.read(profileProvider.notifier).state = ProfileModel(
                  fullName: fullName.text,
                  age: age.text,
                  email: email.text,
                  phone: phone.text,
                  occupation: occupation.text,
                  location: location.text,
                  aboutMe: about.text,
                  imagePath: '',
                );

                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
