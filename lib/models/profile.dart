import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(name: '_id')
  String? id;

  String? facebook;
  String? avatar;
  String? github;
  String? linkedin;

  Profile({
    this.id,
    this.facebook,
    this.avatar,
    this.github,
    this.linkedin,
  });

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
