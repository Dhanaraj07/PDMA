import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/profile_model.dart';
import '../providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final int profileIndex;

  const EditProfileScreen({super.key, required this.profileIndex});

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

  File? selectedImage;

  @override
  void initState() {
    super.initState();

    final profile = ref.read(profileProvider)[widget.profileIndex];

    fullName = TextEditingController(text: profile.fullName);
    age = TextEditingController(text: profile.age);
    email = TextEditingController(text: profile.email);
    phone = TextEditingController(text: profile.phone);
    occupation = TextEditingController(text: profile.occupation);
    location = TextEditingController(text: profile.location);
    about = TextEditingController(text: profile.aboutMe);

    if (profile.imagePath.isNotEmpty) {
      selectedImage = File(profile.imagePath);
    }
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  InputDecoration customDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  void updateProfile() {
    if (fullName.text.trim().isEmpty ||
        age.text.trim().isEmpty ||
        email.text.trim().isEmpty ||
        phone.text.trim().isEmpty ||
        occupation.text.trim().isEmpty ||
        location.text.trim().isEmpty ||
        about.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final updatedProfile = ProfileModel(
      fullName: fullName.text.trim(),
      age: age.text.trim(),
      email: email.text.trim(),
      phone: phone.text.trim(),
      occupation: occupation.text.trim(),
      location: location.text.trim(),
      aboutMe: about.text.trim(),
      imagePath: selectedImage?.path ?? '',
    );

    ref
        .read(profileProvider.notifier)
        .updateProfile(widget.profileIndex, updatedProfile);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully")),
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,

              child: Stack(
                alignment: Alignment.bottomRight,

                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : null,
                    child: selectedImage == null
                        ? const Icon(Icons.person, size: 60)
                        : null,
                  ),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: fullName,
              decoration: customDecoration("Full Name", Icons.person),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: age,
              keyboardType: TextInputType.number,
              decoration: customDecoration("Age", Icons.cake),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: customDecoration("Email", Icons.email),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: customDecoration("Phone Number", Icons.phone),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: occupation,
              decoration: customDecoration("Occupation", Icons.work),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: location,
              decoration: customDecoration("Location", Icons.location_on),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: about,
              maxLines: 4,
              decoration: customDecoration("About Me", Icons.info),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: updateProfile,
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Update Profile",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
