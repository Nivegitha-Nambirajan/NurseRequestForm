import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nurse_enroll/environment.dart';
import 'package:nurse_enroll/model/nurse_request_form.dart';

Future<void> registerNurseRequestForm(NurseForm nurseForm) async {
  final dio = Dio();
  String apiUrl = '${environment['baseUrl']}/profile';
  debugPrint('apiUrl: ${apiUrl}');
  debugPrint('Request data: ${nurseForm.toJson()}');
  try {
    final response = await dio.post(apiUrl, data: nurseForm.toJson());
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response data: ${response.data}');
  } catch (e) {
    debugPrint('Error: $e');
  }
}
