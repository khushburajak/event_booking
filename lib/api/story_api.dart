import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_booking/models/story.dart';
import 'package:event_booking/response/story_response.dart';
import 'package:event_booking/services/http_services.dart';
import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:event_booking/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:motion_toast/motion_toast.dart';

class StoryAPI {
  // Story API to Add Story
  Future<bool> addStory(File? file, Story story) async {
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

      var url = baseUrl + storyUrl + addStoryUrl;
      final token = await Authcontroller.getAuthToken();

      var response = await dio.post(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
        data: FormData.fromMap({
          "title": story.title,
          "image": image,
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

  // Story API to Get All Stories
  Future<StoryResponse?> getAllStories() async {
    StoryResponse? storyResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + storyUrl + getStoryUrl;
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
        storyResponse = StoryResponse.fromJson(response.data);
      } else {
        storyResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return storyResponse;
  }
}
