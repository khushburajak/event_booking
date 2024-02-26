import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_booking/models/event.dart';
import 'package:event_booking/response/get_event_response.dart';
import 'package:event_booking/services/http_services.dart';
import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:event_booking/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:motion_toast/motion_toast.dart';

class EventAPI {
  // Event Api for Creating Event By Authenticated User

  Future<bool> addEvent(File? file, Event event) async {
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

      var url = baseUrl + eventUrl + addEventUrl;
      final token = await Authcontroller.getAuthToken();

      var response = await dio.post(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
        data: FormData.fromMap({
          "title": event.title,
          "content": event.content,
          "category": event.category,
          "eventImage": image,
          "ticketPrice": event.ticketPrice,
          "eventDate": event.eventDate,
          "location": event.location,
          "specialAppereance": event.specialAppereance,
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

  // Event Api for Getting All Events By All(public/private) User

  Future<EventResponse?> getEvents() async {
    EventResponse? eventResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + eventUrl + getEventUrl;
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        eventResponse = EventResponse.fromJson(response.data);
      } else {
        eventResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return eventResponse;
  }

  // Event Api for Getting All Events By User/organizer

  Future<EventResponse?> getEventsByUser() async {
    EventResponse? getEventResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + eventUrl + getEventByUserUrl;
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
        getEventResponse = EventResponse.fromJson(response.data);
      } else {
        getEventResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return getEventResponse;
  }

  // Event Api for Updating event by user/organizer
  Future<bool> updateEvent(File? file, Event event) async {
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

      var url = baseUrl + eventUrl + updateEventUrl;
      // '62d47e971d9800c7c6fc2b2e';
      final token = await Authcontroller.getAuthToken();
      var response = await dio.put(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
        data: FormData.fromMap({
          "id": event.id,
          "title": event.title,
          "content": event.content,
          "category": event.category,
          "eventImage": image,
          "ticketPrice": event.ticketPrice,
          "eventDate": event.eventDate,
          "location": event.location,
          "specialAppereance": event.specialAppereance,
        }),
      );
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

  // Event API for Attending Event By User
  Future<bool> attendEvent(String eventId) async {
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + eventUrl + attendEventUrl;
      var token = await Authcontroller.getAuthToken();
      var response = await dio.put(
        url,
        data: {
          "eventId": eventId,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        MotionToast.error(
            description: const Text("you Already Purchased Event"));
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  // Get Event Which User has Purchased

  Future<EventResponse?> attendingEvent() async {
    EventResponse? getEventResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + eventUrl + attendingEventUrl;
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
        getEventResponse = EventResponse.fromJson(response.data);
      } else {
        getEventResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return getEventResponse;
  }

  // Like Event By User

  Future<bool> likeEvent(String eventId) async {
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + eventUrl + likeEventUrl;
      var token = await Authcontroller.getAuthToken();
      var response = await dio.put(
        url,
        data: {
          "id": eventId,
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
      );
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

  // get like Count of Event
  Future<int> getLikeCount(String eventId) async {
    int likeCount;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + eventUrl + likeCountUrl;
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
        likeCount = response.data['likeCount'];
      } else {
        likeCount = 0;
      }
    } catch (e) {
      throw Exception(e);
    }
    return likeCount;
  }
}
