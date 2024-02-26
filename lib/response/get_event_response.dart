import 'package:event_booking/models/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_event_response.g.dart';

@JsonSerializable()
class EventResponse {
  bool? success;
  List<Event>? events;

  EventResponse({this.success, this.events});

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}
