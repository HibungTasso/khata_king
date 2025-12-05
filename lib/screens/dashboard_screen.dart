import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/transaction_provider.dart';
import 'package:khata_king/screens/all_transaction_history_screen.dart';
import 'package:khata_king/screens/analytics_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double totalCredits = ref.watch(totalCreditsProvider);
    final double todayEarning = ref.watch(totalDebitsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              //Total Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Total Credits
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              "Total Credits",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Rs. $totalCredits",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  //Total Debits
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              "Total Debits",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Rs. $todayEarning",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              //Transactions History
              //____Later show last 3-5 transaction in mini container____
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AllTransactionHistoryScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.history),
                          SizedBox(width: 10),
                          Text(
                            "Transaction History",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              //Monthly Analitics
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,

                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => AnalyticsScreen()),
                      );
                    },
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.analytics_sharp),
                          SizedBox(width: 10),
                          Text(
                            "Montly Analytics",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              //Delete data Button
              OutlinedButton(
                onPressed: () async {
                  final shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text("Confirm Delete"),
                        content: Text(
                          "Are you sure you want to delete ALL data?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldDelete == true) {
                    ref.read(deleteAllCustomersProvider);
                    ref.read(deleteAllTransactionsProvider);

                    //Refresh Customer Transaction lists
                    ref.invalidate(customerListProvider);
                    ref.invalidate(transactionListProvider);

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("All Data Deleted")));
                  }
                },
                child: Text("Delete all Transactions and Customers"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
