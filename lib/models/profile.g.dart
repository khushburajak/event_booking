// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['_id'] as String?,
      facebook: json['facebook'] as String?,
      avatar: json['avatar'] as String?,
      github: json['github'] as String?,
      linkedin: json['linkedin'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      '_id': instance.id,
      'facebook': instance.facebook,
      'avatar': instance.avatar,
      'github': instance.github,
      'linkedin': instance.linkedin,
    };
