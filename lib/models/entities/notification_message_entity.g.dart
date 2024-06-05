// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationMessageEntity _$NotificationMessageEntityFromJson(
        Map<String, dynamic> json) =>
    NotificationMessageEntity(
      message: json['message'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      aqiLevel: json['aqi_level'] as String?,
      aqiValue: json['aqi_value'] as String?,
      pm25: json['pm25'] as String?,
    );

Map<String, dynamic> _$NotificationMessageEntityToJson(
        NotificationMessageEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'aqi_level': instance.aqiLevel,
      'aqi_value': instance.aqiValue,
      'pm25': instance.pm25,
    };
