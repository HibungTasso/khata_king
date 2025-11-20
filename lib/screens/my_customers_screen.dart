import 'package:flutter/material.dart';

class MyCustomersScreen extends StatelessWidget {
  const MyCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Customers"),
      ),

      body: Center(child: Text("[My Customers LIST]"),),
    );
  }
}
