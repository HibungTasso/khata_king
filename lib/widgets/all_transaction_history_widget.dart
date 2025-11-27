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
    if(customer == null){
      return Center(child: Text("No transactions"),);
    }

    //Active Widget (if there are transactions)
    return Container(
      margin: EdgeInsets.all(3),
      child: ListTile(
        title: Text("${customer!.name}"),
        leading: Icon(Icons.person),
        trailing: Text("${transaction.amount}"),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        tileColor: const Color.fromARGB(255, 234, 234, 234),
      ),
    );

  }
}
