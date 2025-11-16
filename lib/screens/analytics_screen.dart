import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() {
    return _AnalyticsScreenState();
  }
}

class _AnalyticsScreenState extends State<AnalyticsScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("[analytics report with daily, weekly, monthly analysis]"),);
  }
}