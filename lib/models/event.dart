import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: '_id')
  String? id;

  String? title;
  String? eventImage;
  String? content;
  String? category;
  int? ticketPrice;
  String? eventDate;
  String? location;
  String? specialAppereance;

  Event({
    this.id,
    this.title,
    this.eventImage,
    this.content,
    this.category,
    this.ticketPrice,
    this.eventDate,
    this.location,
    this.specialAppereance,
  });

  //1. flutter clean
  //2. flutter pub get

//3. flutter pub run build_runner build
  factory Event.fromJson(Map<String, dynamic> json) {
    return _$EventFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
