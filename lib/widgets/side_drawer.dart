import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() {
    return _SideDrawerState();
  }
}

//Stateful because to set DARK MODE
class _SideDrawerState extends State<SideDrawer> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        elevation: 8,
        color: Colors.white,
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: Column(
            children: [
              //Drawer Header
              Container(
                height: 180, // <-- control height
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Hello [USER]",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              //---Menu Items---
              //Transaction
              ListTile(
                title: Text("Transaction History"),
                leading: Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
              SizedBox(height: 10),

              //My Customers
              ListTile(
                title: Text("My Customers"),
                leading: Icon(
                  Icons.people,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
              SizedBox(height: 10),

              //Payment reminder
              ListTile(
                title: Text("Payment Reminder"),
                leading: Icon(
                  Icons.payment,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
              SizedBox(height: 10),

              //Analytics
              ListTile(
                title: Text("Analytics"),
                leading: Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
              SizedBox(height: 10),

              //Dark Mode
              ListTile(
                title: Text("Dark Mode"),
                leading: Icon(
                  Icons.dark_mode,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (isChecked) {
                    setState(() {
                      isDarkMode = isChecked;
                    });
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
              SizedBox(height: 10),

              //Footer - "developed by Hibung Tasso"
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    "Developed by Hibung Tasso",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
