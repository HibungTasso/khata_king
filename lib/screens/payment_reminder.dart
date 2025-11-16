import 'package:flutter/material.dart';

class PaymentReminder extends StatefulWidget {
  const PaymentReminder({super.key});

  @override
  State<PaymentReminder> createState() {
    return _PaymentReminderState();
  }
}

class _PaymentReminderState extends State<PaymentReminder>{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("[Payment Reminder]"),);
  }
}