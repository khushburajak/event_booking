import 'package:event_booking/api/user_api.dart';
import 'package:event_booking/models/user.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserApi().registerUser(user);
  }

  Future<bool> login(String username, String password) async {
    return await UserApi().login(username, password);
  }

  // Forgot Password

  Future<bool> forgotPassword(String email) async {
    return await UserApi().forgotPassword(email);
  }
}
