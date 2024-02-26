import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class User {
  String? name;
  String? email;
  String? username;
  String? password;

  User({
    this.name,
    this.email,
    this.username,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

