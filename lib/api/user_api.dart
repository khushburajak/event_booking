import 'package:dio/dio.dart';
import 'package:event_booking/models/user.dart';
import 'package:event_booking/response/login_response.dart';
import 'package:event_booking/services/http_services.dart';
import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:event_booking/utils/url.dart';
import 'package:flutter/material.dart';

class UserApi {
  Future<bool> registerUser(User user) async {
    bool isSignup = false;
    Response response;
    var url = baseUrl + userUrl + registerUrl;
    var dio = HttpServices().getDioInstance();

    try {
      response = await dio.post(url, data: user.toJson());
      debugPrint(response.toString());
      if (response.statusCode == 201) {
        debugPrint("User Signup Successfully");
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isSignup;
  }

  Future<bool> login(String username, String password) async {
    bool isLogin = false;
    var url = baseUrl + userUrl + loginUrl;
    var dio = HttpServices().getDioInstance();

    try {
      var response = await dio.post(url, data: {
        'username': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        LoginRespone loginResponse = LoginRespone.fromJson(response.data);
        token = loginResponse.token;
        isLogin = true;

        // Authcontroller is a instance of the class in the controller folder that has function to store token in a shared preference
        Authcontroller().setAuthToken(token!);

        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  // Forgot Password
  Future<bool> forgotPassword(String email) async {
    bool isUpdated = false;
    var url = baseUrl + userUrl + forgotPasswordUrl;
    var dio = HttpServices().getDioInstance();

    try {
      var response = await dio.put(url, data: {
        'email': email,
      });
      if (response.statusCode == 200) {
        isUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUpdated;
  }
}
