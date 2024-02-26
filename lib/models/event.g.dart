// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      eventImage: json['eventImage'] as String?,
      content: json['content'] as String?,
      category: json['category'] as String?,
      ticketPrice: json['ticketPrice'] as int?,
      eventDate: json['eventDate'] as String?,
      location: json['location'] as String?,
      specialAppereance: json['specialAppereance'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'eventImage': instance.eventImage,
      'content': instance.content,
      'category': instance.category,
      'ticketPrice': instance.ticketPrice,
      'eventDate': instance.eventDate,
      'location': instance.location,
      'specialAppereance': instance.specialAppereance,
    };
