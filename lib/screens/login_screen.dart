import 'package:flutter/material.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneCtrl = TextEditingController();
  String? error;

  void validateAndLogin() {
    final phone = phoneCtrl.text.trim();

    if (phone.length >= 3 && phone.length <= 10) {
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } else {
      setState(() {
        error = "Enter a valid phone number (3–10 digits)";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: const OutlineInputBorder(),
                  errorText: error,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: validateAndLogin,
                child: const Text("Login"),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.signup);
                },
                child: const Text("Create New Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
