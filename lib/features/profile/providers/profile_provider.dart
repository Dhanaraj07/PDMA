import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/profile_model.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, List<ProfileModel>>(
      (ref) => ProfileNotifier(),
    );

class ProfileNotifier extends StateNotifier<List<ProfileModel>> {
  ProfileNotifier() : super([]) {
    loadProfiles();
  }

  Future<void> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('profiles');

    if (data != null) {
      final List decoded = jsonDecode(data);

      state = decoded.map((e) => ProfileModel.fromMap(e)).toList();
    }
  }

  Future<void> saveProfiles() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonData = state.map((profile) => profile.toMap()).toList();

    await prefs.setString('profiles', jsonEncode(jsonData));
  }

  Future<void> addProfile(ProfileModel profile) async {
    state = [...state, profile];

    await saveProfiles();
  }

  Future<void> updateProfile(int index, ProfileModel profile) async {
    final updated = [...state];

    updated[index] = profile;

    state = updated;

    await saveProfiles();
  }

  Future<void> deleteProfile(int index) async {
    final updated = [...state];

    updated.removeAt(index);

    state = updated;

    await saveProfiles();
  }
}
