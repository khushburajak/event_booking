import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String username;
  String email;
  String password;

  User(
    this.name,
    this.username,
    this.email,
    this.password,
  );
}
