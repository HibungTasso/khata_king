import 'package:flutter/material.dart';
import 'package:khata_king/screens/analytics_screen.dart';
import 'package:khata_king/screens/dashboard_screen.dart';
import 'package:khata_king/screens/add_customer_screen.dart';
import 'package:khata_king/screens/transaction_history_screen.dart';
import 'package:khata_king/widgets/side_drawer.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _activeScreens = const [
    DashboardScreen(),
    AddCustomerScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar (can be dynamic later)
      appBar: AppBar(
        title: const Text("Khata King"),
      ),

      //Side Drawer
      drawer: SideDrawer(),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined,),
            label: "Add Customer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),
        ],
      ),

      body: _activeScreens[_currentIndex],
    );
  }
}
