import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/transaction_provider.dart';
import 'package:khata_king/screens/customer_details_screen.dart';

class CustomerTile extends ConsumerWidget {
  const CustomerTile({
    super.key,
    required this.customer,
    required this.name,
    required this.balance,
    required this.phone,
  });

  final Customers customer;
  final String name;
  final double balance;
  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Background Container
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        //Styling
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        color: Theme.of(context).colorScheme.secondaryContainer,

        //Tile
        child: ListTile(
          title: Text(name, style: TextStyle(fontSize: 20)),
          subtitle: Text(phone),
          trailing: PopupMenuButton<String>(
            onSelected: (value) async{
              if(value == 'delete'){
                //Delete Transactions with customer Id -> then Deleter Customer 
                final db = DbHelper.instance;
                await db.deleteAllTransactionsByCustomerId(customer.id!);
                await db.deleteCustomerById(customer.id!);

                //refresh list in UI
                ref.invalidate(customerListProvider);
                ref.invalidate(transactionListProvider);
              }
            },
            itemBuilder: (ctx){
              return [
                PopupMenuItem(
                  value: 'delete',
                  child: Text("Delete"),
                ),
              ];
            },

            icon: Icon(Icons.more_vert_outlined,),
            ),
          leading: Icon(Icons.person),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          //onTap
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) {
                  return CustomerDetailsScreen(customer: customer);
                },
              ),
            );
          },

          //onLongPress (DELETE option)
          onLongPress: () {},
        ),
      ),
    );
  }
}
