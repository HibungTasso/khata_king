import 'package:flutter/material.dart';
import '../routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo.shade400,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.account_circle, color: Colors.white, size: 50),
                SizedBox(height: 8),
                Text(
                  "Shopkeeper",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.dashboard);
            },
          ),

          // Transactions
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Transactions"),
            onTap: () {
              Navigator.pushNamed(context, "/transactions");
            },
          ),

          // Add Transaction
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Add Transaction"),
            onTap: () {
              Navigator.pushNamed(context, "/add-transaction");
            },
          ),

          // Reports
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Reports"),
            onTap: () {
              Navigator.pushNamed(context, "/reports");
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
