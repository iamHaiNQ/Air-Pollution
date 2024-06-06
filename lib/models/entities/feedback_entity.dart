import 'package:json_annotation/json_annotation.dart';

part 'feedback_entity.g.dart';

@JsonSerializable()
class FeedbackEntity {
  final String? email;
  final String? userName;
  final String? address;
  final String? populationType;
  final String? populationLevel;
  final String? content;
  final String? imageLink;

  FeedbackEntity({
    this.email,
    this.userName,
    this.address,
    this.populationType,
    this.populationLevel,
    this.content,
    this.imageLink,
  });

  factory FeedbackEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedbackEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackEntityToJson(this);
}
