import 'package:json_annotation/json_annotation.dart';

part 'notification_message_entity.g.dart';

@JsonSerializable()
class NotificationMessageEntity {
  NotificationMessageEntity({
    this.message,
    this.type,
    this.body,
  });

  @JsonKey()
  String? body;
  @JsonKey()
  String? message;
  @JsonKey()
  String? type;

  factory NotificationMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationMessageEntityToJson(this);
}
