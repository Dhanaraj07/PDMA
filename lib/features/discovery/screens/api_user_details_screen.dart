import 'package:flutter/material.dart';

class ApiUserDetailsScreen extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String location;

  const ApiUserDetailsScreen({
    super.key,
    required this.name,
    required this.email,
    required this.image,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            CircleAvatar(radius: 70, backgroundImage: NetworkImage(image)),

            const SizedBox(height: 20),

            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text("Email"),
                    subtitle: Text(email),
                  ),

                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text("Location"),
                    subtitle: Text(location),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
