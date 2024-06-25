import 'package:flutter/material.dart';

class FeedbackModel {
  final String date;
  final String feedback;
  final String studentId;

  FeedbackModel({
    required this.date,
    required this.feedback,
    required this.studentId,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      date: map['date'] ?? '',
      feedback: map['feedback'] ?? '',
      studentId: map['studentId'] ?? '',
    );
  }
}
