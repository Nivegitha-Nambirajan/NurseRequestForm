import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nurse_enroll/model/form_manager.dart';
import 'package:nurse_enroll/views/request_form.dart';
import 'package:nurse_enroll/views/splash_screen.dart';
import 'package:nurse_enroll/widgets/submit_button.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NurseRequestFormManager _formManager = NurseRequestFormManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NurseRequestForm(formKey: _formKey, formManager: _formManager),
              const SizedBox(height: 20),
              SubmitButton(formKey: _formKey, formManager: _formManager)
            ],
          ),
        ),
      ),
    );
  }
}
