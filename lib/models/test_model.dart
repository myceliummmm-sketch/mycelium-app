import 'package:flutter/material.dart';
import 'sphere.dart';
import 'metaskill.dart';

class TestModel {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final int duration; // minutes
  final int reward; // MYC tokens
  final double progress; // 0.0 to 1.0
  final bool isCompleted;
  final bool isLocked;
  final bool isNew;
  final List<Sphere> spheres;
  final List<Metaskill> metaskills;
  final Gradient gradient;

  const TestModel({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.duration,
    required this.reward,
    this.progress = 0.0,
    this.isCompleted = false,
    this.isLocked = false,
    this.isNew = false,
    required this.spheres,
    required this.metaskills,
    required this.gradient,
  });
}
