import 'package:flutter/material.dart';
import '../routes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Just go back to Login
              },
              child: const Text("Sign Up"),
            ),

            SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.login);
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
