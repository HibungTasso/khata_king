import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:khata_king/providers/transaction_provider.dart';

class CustomerTransactionsHistoryTile extends ConsumerWidget {
  const CustomerTransactionsHistoryTile({
    super.key,
    required this.date,
    required this.time,
    required this.note,
    required this.amount,
    required this.type,
    required this.transaction,
  });

  final String date;
  final String time;
  final String note;
  final double amount;
  final String type;
  final Transactions transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Delete Transaction"),
              content: Text(
                "Do you want to delete this transaction?",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(deleteTransactionByIdProvider(transaction.id!));

                    //refresh UI
                    ref.invalidate(getTransactionsByCustomerIdProvider(transaction.customerId));
                    ref.invalidate(getCustomerBalanceByIdProvider(transaction.customerId));

                    //Pop screen
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          );
        },

        child: Container(
          margin: EdgeInsets.all(1),
          color: Theme.of(
            context,
          ).colorScheme.secondaryContainer.withAlpha(200),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                //Date-Time and note
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Date-Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text("$date"),
                            SizedBox(width: 2),
                            Text("$time", style: TextStyle(fontSize: 8)),
                          ],
                        ),

                        //Note
                        SizedBox(
                          width: 130,
                          child: Text(
                            "${note.trim()}",
                            style: TextStyle(fontSize: 8),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Amount(You Got) - Dynamic
                Expanded(
                  flex: 1,
                  child: Align(
                    child: type == "debit"
                        ? Text(
                            "$amount",
                            style: TextStyle(color: Colors.green, fontSize: 10),
                          )
                        : SizedBox(),
                  ),
                ),

                //Amount(You Gave) - Dynamic
                Expanded(
                  flex: 1,
                  child: Align(
                    child: type == "credit"
                        ? Text(
                            "$amount",
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          )
                        : SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
