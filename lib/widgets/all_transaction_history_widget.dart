import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/models/transactions.dart';

class AllTransactionHistoryWidget extends ConsumerWidget {
  const AllTransactionHistoryWidget({
    super.key,
    required this.transaction,
    required this.customer,
  });

  final Transactions transaction;
  final Customers? customer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Check if transaction is credit or debit [credit = RED]
    final isCredit = (transaction.type == 'credit');

    if (customer == null) {
      return Center(child: Text("No transactions"));
    }

    //Active Widget (if there are transactions)
    return Container(
      margin: EdgeInsets.all(3),
      child: ListTile(
        title: Text("${customer!.name}"),
        leading: Icon(Icons.person),
        trailing: Text(
          "${isCredit ? "-" : "+"} Rs. ${transaction.amount}",
          style: TextStyle(color: isCredit ? Colors.red : Colors.green, fontSize: 15),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        tileColor: isCredit
            ? const Color.fromARGB(255, 243, 223, 223)
            : const Color.fromARGB(255, 207, 239, 224),
      ),
    );
  }
}
