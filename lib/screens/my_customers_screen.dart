import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    //get Customer List from provider
    final customerList = ref.watch(customerListProvider);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),

        //manage three states
        child: customerList.when(
          //show Data
          data: (list) {
            //If List is Empty
            if (list.isEmpty) {
              return Center(child: Text("No Customer Added"));
            }

            //If List has Data
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
            Center(child: CircularProgressIndicator());
            return null;
          },

          error: (error, stackTrace) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
