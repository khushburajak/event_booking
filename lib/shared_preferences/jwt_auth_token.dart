import 'package:shared_preferences/shared_preferences.dart';

// making class to store the token in a local device via shared preferences
class Authcontroller {
// as we are using shared preferences to store the token in the device we need to make a method to set and get the token from the shared preferences
// this method will set the token in the shared preferences
  Future<bool> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AuthStatus.authToken.toString(), token);
  }

  // this method will get the token from the shared preferences
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthStatus.authToken.toString());
  }

  // this method will remove the token from the shared preferences
  static Future<bool> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(AuthStatus.authToken.toString());
  }
}

enum AuthStatus {
  authToken,
}
