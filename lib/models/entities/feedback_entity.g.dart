// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackEntity _$FeedbackEntityFromJson(Map<String, dynamic> json) =>
    FeedbackEntity(
      address: json['address'] as String?,
      populationType: json['populationType'] as String?,
      populationLevel: json['populationLevel'] as String?,
      content: json['content'] as String?,
      imageLink: json['imageLink'] as String?,
    );

Map<String, dynamic> _$FeedbackEntityToJson(FeedbackEntity instance) =>
    <String, dynamic>{
      'address': instance.address,
      'populationType': instance.populationType,
      'populationLevel': instance.populationLevel,
      'content': instance.content,
      'imageLink': instance.imageLink,
    };
