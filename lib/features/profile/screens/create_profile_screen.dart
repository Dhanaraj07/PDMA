import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/profile_model.dart';
import '../providers/profile_provider.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  ConsumerState<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final occupationController = TextEditingController();
  final locationController = TextEditingController();
  final aboutController = TextEditingController();

  File? selectedImage;

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

  void saveProfile() {
    if (fullNameController.text.trim().isEmpty ||
        ageController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        occupationController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty ||
        aboutController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final profile = ProfileModel(
      fullName: fullNameController.text.trim(),
      age: ageController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      occupation: occupationController.text.trim(),
      location: locationController.text.trim(),
      aboutMe: aboutController.text.trim(),
      imagePath: selectedImage?.path ?? '',
    );

    ref.read(profileProvider.notifier).addProfile(profile);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Created Successfully")),
    );

    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Profile"), centerTitle: true),

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
              controller: fullNameController,
              decoration: customDecoration("Full Name", Icons.person),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: customDecoration("Age", Icons.cake),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: customDecoration("Email", Icons.email),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: customDecoration("Phone Number", Icons.phone),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: occupationController,
              decoration: customDecoration("Occupation", Icons.work),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: locationController,
              decoration: customDecoration("Location", Icons.location_on),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: aboutController,
              maxLines: 4,
              decoration: customDecoration("About Me", Icons.info),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: saveProfile,
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save Profile",
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
