import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/customers.dart';

class CustomerTransactionsHistory extends ConsumerWidget {
  const CustomerTransactionsHistory({super.key, required this.customer});

  final Customers customer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      margin: EdgeInsets.all(5),
      color: const Color.fromARGB(255, 225, 225, 225),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [

            //Date and note
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Date and Time
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("${customer.created_date}"),SizedBox(width: 2,),
                        Text("${customer.time}", style: TextStyle(fontSize: 8),)
                      ],
                    ),

                    //Note
                    SizedBox(
                      width: 130,
                      child: Text("Test note",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            //You Got /*+++++DYNAMIC credit or debit++++++ */
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text("Rs. 500", style: TextStyle(color: Colors.green, fontSize: 13))),
            ),
        
            //You Gave
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text("200", style: TextStyle(color: Colors.red, fontSize: 12))),
            ),
          ],
        ),
      ),
    );
  }
}
