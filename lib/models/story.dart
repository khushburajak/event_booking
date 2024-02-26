import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  @JsonKey(name: '_id')
  String? id;

  String? image;
  String? title;

  Story({
    this.id,
    this.image,
    this.title,
  });

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory Story.fromJson(Map<String, dynamic> json) {
    return _$StoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
