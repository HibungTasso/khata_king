import 'package:flutter/material.dart';

class PaymentReminderScreen extends StatefulWidget {
  const PaymentReminderScreen({super.key});

  @override
  State<PaymentReminderScreen> createState() {
    return _PaymentReminderState();
  }
}

class _PaymentReminderState extends State<PaymentReminderScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Reminder"),
      ),
      body: Center(child: Text("[Payment Reminder]"),),
    );
  }
}