import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/providers/navigation_provider.dart';
import 'package:khata_king/screens/analytics_screen.dart';
import 'package:khata_king/screens/dashboard_screen.dart';
import 'package:khata_king/screens/add_customer_screen.dart';
import 'package:khata_king/widgets/side_drawer.dart';

class Navigation extends ConsumerStatefulWidget {
  const Navigation({super.key});

  @override
  ConsumerState<Navigation> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {

  final List<Widget> _activeScreens = const [
    DashboardScreen(),
    AddCustomerScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int _currentIndex = ref.read(navigationProvider);

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
            ref.read(navigationProvider.notifier).state = value;
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
