import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/customers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:khata_king/providers/transaction_provider.dart';
import 'package:khata_king/widgets/customer_transactions_history.dart';
import 'package:sqflite/sqlite_api.dart';

class CustomerDetailsScreen extends ConsumerStatefulWidget {
  const CustomerDetailsScreen({super.key, required this.customer});

  final Customers customer;

  @override
  ConsumerState<CustomerDetailsScreen> createState() {
    return _CustomerDetailsScreenState();
  }
}

class _CustomerDetailsScreenState extends ConsumerState<CustomerDetailsScreen> {
  //Customer details
  late double _balance;
  late String _name;

  //Initialization before UI loads
  @override
  void initState() {
    super.initState();

    //Initialize late variables here
    _balance = widget.customer.balance;
    _name = widget.customer.name;
  }

  @override
  Widget build(BuildContext context) {
    //Get Transactions by customer id (returns AsyncValue<List<Transactions>>)
    final transactions = ref.watch(getTransactionsByCustomerIdProvider(widget.customer.id!));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //icon
            Icon(Icons.person),
            SizedBox(width: 10),

            //Title
            Text(_name),
          ],
        ),
      ),

      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            //Balance Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    //Upper
                    Row(
                      children: [
                        //Balance Text
                        Text(
                          "Balance",
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Spacer(), //space till the end
                        //Amount and Text (You will get/ You will give)
                        Text(
                          //Amount
                          "Rs. ${_balance.toStringAsFixed(2)}",
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),

                    //Spaces
                    SizedBox(height: 10),
                    Divider(thickness: 1),

                    //Lower
                    Center(
                      /* ++++++ Later -> Dynamic Text ++++++ */
                      child: Text(
                        "You will get",
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            //Buttons
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  //Report
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      splashColor: const Color.fromARGB(255, 128, 139, 137),
                      child: Ink(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        color: Theme.of(context).colorScheme.primary,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.analytics,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              "Reports",
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Vertical Divider
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(thickness: 1, width: 1),
                  ),

                  //Reminder
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      splashColor: const Color.fromARGB(255, 128, 139, 137),
                      child: Ink(
                        padding: EdgeInsets.all(5),
                        height: 50,
                        color: Theme.of(context).colorScheme.primary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Icon
                            Image.asset(
                              "assets/images/whatsapp_logo.png",
                              height: 21,
                            ),

                            //Text
                            Text(
                              "Reminder",
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Transaction History
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary.withAlpha(10),
                  child: Column(
                    children: [
                      //header
                      Center(child: Text("Transaction History")),
              
                      //Table Title
                      Container(
                        color: Theme.of(context).colorScheme.secondaryContainer.withAlpha(200),
                        padding: EdgeInsets.fromLTRB(25, 3, 0, 3),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "\t\t\t\t\t\t\tDate",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(fontSize: 10),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "You Got",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(fontSize: 10),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "You Gave",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
              
                      //List item of Transactions(manage AsyncValue<List<Transactions>>)
                      Expanded(
                        child: transactions.when(
                          data: (list) {
                            return SizedBox(
                              height: double.infinity,
                              child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (ctx, index) {
                                  return CustomerTransactionsHistory(
                                    date: list[index].created_date, 
                                    time: list[index].time, 
                                    note: list[index].note, 
                                    amount: list[index].amount, 
                                    type: list[index].type);
                                },
                              ),
                            );
                          },
                        
                          //Loading and error
                          loading: () => Center(child: CircularProgressIndicator(),),
                          error: (error, stackTrace) => Center(child: Text('Error Occured in getTransactionsByCustomerIdProvider'),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
