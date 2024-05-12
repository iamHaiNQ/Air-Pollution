import 'package:flutter/material.dart';

class HealthLevelInfoEntity {
  final int max;
  final int min;
  final String title;
  final String description;
  final String imgLink;
  final Color backgroundColor;

  HealthLevelInfoEntity({
    required this.max,
    required this.min,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.backgroundColor,
  });
}
