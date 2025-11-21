import 'package:flutter/material.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/widgets/customer_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/providers/customer_providers.dart';

class MyCustomersScreen extends ConsumerStatefulWidget {
  const MyCustomersScreen({super.key});

  @override
  ConsumerState<MyCustomersScreen> createState() {
    return _MyCustomersScreenState();
  }
}

class _MyCustomersScreenState extends ConsumerState<MyCustomersScreen> {
  var customerList = [];


  @override
  Widget build(BuildContext context) {
    //get Customer List from provider
    final customerList = ref.watch(customerListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("My Customers")),

      //manage three states
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: customerList.when(
          //show Data
          data: (list) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (ctx, index) {
                return CustomerTile(
                  name: list[index].name,
                  balance: list[index].balance,
                  phone: list[index].phone,
                );
              },
            );
          },
        
          loading: () {
            Center(child: CircularProgressIndicator(),);
            return null;
          },
        
          error: (error, stackTrace) => Center(child: Text(error.toString()),),
        ),
      ),
    );
  }
}
