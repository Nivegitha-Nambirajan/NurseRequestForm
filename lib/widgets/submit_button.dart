import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nurse_enroll/api/request_form_api.dart';
import 'package:nurse_enroll/model/form_manager.dart';
import 'package:nurse_enroll/model/nurse_request_form.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.formManager,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final NurseRequestFormManager formManager;

  Future<void> _simulateApiCall(BuildContext context, NurseForm profile) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        _toastBar(
          message: "Internet not available",
          isError: true,
          icon: Icons.wifi_off,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xff3b42ba),
          ),
        );
      },
    );
    await registerNurseRequestForm(profile);

    Navigator.of(context).pop();

    bool isSuccess = true;

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        _toastBar(
          message: "Registered successfully!",
          isError: false,
          icon: Icons.check_circle,
        ),
      );
    }
  }

  SnackBar _toastBar({
    required String message,
    required bool isError,
    required IconData icon,
  }) {
    return SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      content: Container(
        decoration: BoxDecoration(
          color: isError ? Colors.red : Colors.green,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isError ? "Error" : "Success",
                    style: const TextStyle(
                        fontFamily: "Manrope", color: Colors.white),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.44,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xff3b42ba),
                  ),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Color(0xff3b42ba),
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3b42ba),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final profile = formManager.collectFormData();
                    await _simulateApiCall(context, profile);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill all required fields')),
                    );
                  }
                },
                child: const Text(
                  "Request",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
