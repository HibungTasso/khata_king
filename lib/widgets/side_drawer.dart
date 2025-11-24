import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/providers/navigation_provider.dart';
import 'package:khata_king/providers/theme_provider.dart';

class SideDrawer extends ConsumerStatefulWidget {
  const SideDrawer({super.key});

  @override
  ConsumerState<SideDrawer> createState() {
    return _SideDrawerState();
  }
}

//Stateful because to set DARK MODE
class _SideDrawerState extends ConsumerState<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    //Get themeMode from ThemeProvider
    bool isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

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
              //Transaction History
              ListTile(
                onTap: () {},
                title: Text("Transaction History", style: Theme.of(context).textTheme.titleSmall,),
                leading: Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
              ),
              SizedBox(height: 5),

              //My Customers
              ListTile(
                title: Text("My Customers", style: Theme.of(context).textTheme.titleSmall),
                onTap: () {
                  Navigator.of(context).pop();
                  ref.read(navigationProvider.notifier).state = 2;
                },
                leading: Icon(
                  Icons.people,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
              ),
              SizedBox(height: 5),

              //Payment reminder
              ListTile(
                title: Text("Payment Reminder",style: Theme.of(context).textTheme.titleSmall),
                leading: Icon(
                  Icons.payment,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
              ),
              SizedBox(height: 5),

              //Analytics
              ListTile(
                title: Text("Analytics", style: Theme.of(context).textTheme.titleSmall),
                leading: Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
              ),
              SizedBox(height: 5),

              //Dark Mode
              ListTile(
                title: Text("Dark Mode", style: Theme.of(context).textTheme.titleSmall),
                leading: Icon(
                  Icons.dark_mode,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (isChecked) {
                    if (isChecked) {
                      ref.read(themeProvider.notifier).state = ThemeMode.dark;
                    } else {
                      ref.read(themeProvider.notifier).state = ThemeMode.light;
                    }
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                tileColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withAlpha(100),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
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
