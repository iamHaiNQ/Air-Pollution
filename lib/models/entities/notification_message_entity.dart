import 'package:json_annotation/json_annotation.dart';

part 'notification_message_entity.g.dart';

@JsonSerializable()
class NotificationMessageEntity {
  NotificationMessageEntity({
    this.message,
    this.type,
    this.title,
    this.aqiLevel,
    this.aqiValue,
    this.pm25,
  });

  @JsonKey()
  String? title;
  @JsonKey()
  String? message;
  @JsonKey()
  String? type;
  @JsonKey(name: "aqi_level")
  String? aqiLevel;

  @JsonKey(name: "aqi_value")
  String? aqiValue;

  @JsonKey()
  String? pm25;

  factory NotificationMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMessageEntityToJson(this);
}
