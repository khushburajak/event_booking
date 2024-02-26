import 'package:event_booking/floor_database/entities/user_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDAO {
  // register user
  @insert
  Future<void> insertUser(User user);

  // login user
  @Query(
      'SELECT * FROM user WHERE username = :username AND password = :password')
  Future<User?> login(String username, String password);
}
