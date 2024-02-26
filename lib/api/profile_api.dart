import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_booking/models/profile.dart';
import 'package:event_booking/response/profile_response.dart';
import 'package:event_booking/services/http_services.dart';
import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:event_booking/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:motion_toast/motion_toast.dart';

class ProfileAPI {
  Future<bool> createProfile(File? file, Profile profile) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);

        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        ); // image/jpeg -> jpeg
      }

      var url = baseUrl + profileUrl + createProfileUrl;
      final token = await Authcontroller.getAuthToken();

      var response = await dio.post(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
        data: FormData.fromMap({
          "avatar": image,
          "facebook": profile.facebook,
          "instagram": profile.linkedin,
          "github": profile.github,
        }),
      );
      debugPrint(response.toString());
      if (response.statusCode == 201) {
        return true;
      } else {
        MotionToast.error(description: const Text("Something went wrong"));
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<ProfileResponse?> getProfile() async {
    ProfileResponse? profileResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + profileUrl + getProfileUrl;
      final token = await Authcontroller.getAuthToken();

      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
      );
      if (response.statusCode == 200) {
        profileResponse = ProfileResponse.fromJson(response.data);
      } else {
        profileResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return profileResponse;
  }

  Future<bool> updateProfile(File? file, Profile profile) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);

        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        ); // image/jpeg -> jpeg
      }

      var url = baseUrl + profileUrl + updateProfileUrl;
      final token = await Authcontroller.getAuthToken();

      var response = await dio.put(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
        data: FormData.fromMap({
          "avatar": image,
          "facebook": profile.facebook,
          "instagram": profile.linkedin,
          "github": profile.github,
        }),
      );
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return true;
      } else {
        MotionToast.error(description: const Text("Something went wrong"));
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }
}
// 03006381