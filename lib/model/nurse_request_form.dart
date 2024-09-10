import 'package:flutter/material.dart';

class NurseForm {
  final String typeOfCare;
  final String typeOfService;
  final String nurseCount;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final int duration;
  final bool repeatOnEvery;
  final List<String>? selectedDays;
  final List<String> documents;
  final String additionalNotes;

  NurseForm(
      {required this.typeOfCare,
      required this.typeOfService,
      required this.nurseCount,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.duration,
      required this.repeatOnEvery,
      required this.selectedDays,
      required this.documents,
      required this.additionalNotes});

  Map<String, dynamic> toJson() {
    return {
      "typeOfCare": typeOfCare,
      "typeOfService": typeOfService,
      "nurseCount": nurseCount,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "startTime": startTime,
      "duration": duration,
      "repeatOnEvery": repeatOnEvery,
      "selectedDays": selectedDays,
      "documents": documents,
    };
  }
}
