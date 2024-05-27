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
      body: json['body'] as String?,
    );

Map<String, dynamic> _$NotificationMessageEntityToJson(
        NotificationMessageEntity instance) =>
    <String, dynamic>{
      'body': instance.body,
      'message': instance.message,
      'type': instance.type,
    };
