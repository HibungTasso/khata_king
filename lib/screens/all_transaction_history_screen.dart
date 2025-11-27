import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/transaction_provider.dart';
import 'package:khata_king/widgets/all_transaction_history_widget.dart';

class AllTransactionHistoryScreen extends ConsumerWidget {
  const AllTransactionHistoryScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTransactionList = ref.watch(transactionListProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body: Container(
        margin: EdgeInsets.all(10),
        child: allTransactionList.when(
          data: (allTransactionList){
            return ListView.builder(
              itemCount: allTransactionList.length,
              itemBuilder: (ctx, index){
                //Get customer object by id
                final customer = ref.watch(getCustomerByIdProvider(allTransactionList[index].customerId));
                return customer.when(
                  data: (customer){
                    return AllTransactionHistoryWidget(transaction: allTransactionList[index], customer: customer);
                  },

                  //Loading and error
                  loading: () => Center(child: CircularProgressIndicator(),),
                  error: (error, stackTrace) => Center(child: Text("Error in getCustomeByIdProvider"),),
                );
                print("++++++${allTransactionList[index].customerId}++++");

              },
            );
          },

          //Loading and error
          loading: ()=>Center(child: CircularProgressIndicator(),),
          error: (error, stackTrace) => Center(child: Text("Error on TransactionList Provider"),),
        ),
      ),
    );
  }
}
