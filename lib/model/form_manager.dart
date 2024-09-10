import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nurse_enroll/model/nurse_request_form.dart';

class NurseRequestFormManager {
  String? typeOfCare;
  String? typeOfService;
  final TextEditingController nurseCount = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedTime;
  int duration = 8;
  List<PlatformFile> documents = [];
  bool repeatOnEvery = false;
  List<String> selectedDays = [];
  final TextEditingController additionalNotes = TextEditingController();

  NurseForm collectFormData() {
    return NurseForm(
        nurseCount: nurseCount.text,
        typeOfCare: typeOfCare ?? "",
        typeOfService: typeOfService ?? "",
        startDate: selectedStartDate ?? DateTime.now(),
        endDate: selectedEndDate ?? DateTime.now(),
        startTime: selectedTime ?? TimeOfDay.now().toString(),
        duration: duration,
        documents: documents.map((file) => file.name).toList(),
        repeatOnEvery: repeatOnEvery,
        selectedDays: selectedDays,
        additionalNotes: additionalNotes.text);
  }
}
