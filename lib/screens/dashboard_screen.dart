import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/firestore_provider.dart';
import 'package:khata_king/providers/transaction_provider.dart';
import 'package:khata_king/screens/all_transaction_history_screen.dart';
import 'package:khata_king/screens/analytics_screen.dart';
import 'package:khata_king/services/delete_service.dart';
import 'package:khata_king/services/sync_service.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double totalCredits = ref.watch(totalCreditsProvider);
    final double todayEarning = ref.watch(totalDebitsProvider);
    final isLoading = ref.watch(syncLoadingProvider);

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 10),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Rs. $totalCredits",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 10),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Rs. $todayEarning",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
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
                              MaterialPageRoute(
                                builder: (ctx) => AnalyticsScreen(),
                              ),
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    //Sync Data Button
                    SizedBox(
                      width: 330,
                      child: OutlinedButton(
                        onPressed: () async {
                          try {
                            ref.read(syncLoadingProvider.notifier).state = true;
                            await SyncService().syncData();
                            //show snack bar if there is no error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Data Synced")),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")),
                            );
                          } finally {
                            ref.read(syncLoadingProvider.notifier).state =
                                false;
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        child: Text("Sync data online"),
                      ),
                    ),
                    SizedBox(height: 20),

                    //Delete data Button
                    SizedBox(
                      width: 330,
                      child: OutlinedButton(
                        onPressed: () async {
                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text("Confirm Delete"),
                                content: Text(
                                  "Are you sure you want to DELETE all data?",
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
                            try {
                              await DeleteService().deleteData(ref);

                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("All Data Deleted")),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        child: Text("Delete all Data"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
