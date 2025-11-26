import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/customers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_king/widgets/customer_transactions_history.dart';

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
  late Customers currentCustomer;

  //Initialization before UI loads
  @override
  void initState() {
    super.initState();

    //Initialize late variables here
    _balance = widget.customer.balance;
    _name = widget.customer.name;
    currentCustomer = widget.customer;
  }

  @override
  Widget build(BuildContext context) {
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
                          style: GoogleFonts.poppins(
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
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Report
                    InkWell(
                      onTap: () {},
                      splashColor: const Color.fromARGB(255, 128, 139, 137),
                      child: Ink(
                        width: 100,
                        height: 80,
                        padding: EdgeInsets.all(5),
                        color: const Color.fromARGB(255, 190, 199, 203),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.analytics, size: 40),
                            SizedBox(height: 10),
                            Text(
                              "Reports",
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(
                                  context,
                                ).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 40),

                    //Reminder
                    InkWell(
                      onTap: () {},
                      splashColor: const Color.fromARGB(255, 128, 139, 137),
                      child: Ink(
                        padding: EdgeInsets.all(5),
                        width: 100,
                        height: 80,
                        color: const Color.fromARGB(255, 190, 199, 203),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Icon
                            Icon(Icons.phone, size: 40), SizedBox(width: 10),

                            //Text
                            Text(
                              "Reminder",
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(
                                  context,
                                ).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            //Transaction History
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 212, 212, 212),
              child: Column(
                children: [
                  //header
                  Center(child: Text("Transaction History")),

                  //Table Title
                  Container(
                    color: const Color.fromARGB(255, 218, 243, 31),
                    padding: EdgeInsets.fromLTRB(25, 3, 0, 3),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                  //List of Transactions /* +++ MAKE LIST ++++ */
                  CustomerTransactionsHistory(customer: currentCustomer)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
