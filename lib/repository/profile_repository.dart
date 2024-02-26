import 'dart:io';

import 'package:event_booking/api/profile_api.dart';
import 'package:event_booking/models/profile.dart';
import 'package:event_booking/response/profile_response.dart';

class ProfileRepository {
  Future<bool> createProfile(File? file, Profile event) async {
    return ProfileAPI().createProfile(file, event);
  }

  Future<ProfileResponse?> getProfile() async {
    return ProfileAPI().getProfile();
  }

  Future<bool> updateProfile(File? file, Profile event) async {
    return ProfileAPI().updateProfile(file, event);
  }
}
