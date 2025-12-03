import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/navigation_provider.dart';
import 'package:khata_king/providers/transaction_provider.dart';
import 'package:khata_king/widgets/toggle_credit_debit.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  ConsumerState<AddCustomerScreen> createState() {
    return _AddCustomerState();
  }
}

class _AddCustomerState extends ConsumerState<AddCustomerScreen> {
  //getting ready the data for creating new customer object
  String? _name, _phone, _type;
  double? _balance;

  //Controllers
  final _balanceController = TextEditingController(text: "0");

  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Save Button
  void _onSave() async {
    //Check if form is invalid
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // //Otherwise save all fields
    _formKey.currentState!.save();

    // //Save Current Date and time
    final today = DateTime.now();
    final createdDate = "${today.day}/${today.month}/${today.year}";
    final time = DateFormat('hh:mm a').format(today);

    final customer = Customers(
      name: _name!,
      phone: _phone!,
      created_date: createdDate,
      time: time,
      balance: 0, //initially, balance be 0 because transaction will be initiate with input balance
    );

    // //Insert New Customer to Customer table
    final newCustomerId = await DbHelper.instance.addCustomer(customer);


    // //Add new Transaction to this New Customer in Transaction Table
    if (_balance != null && _type != null) {
      //   // 1. balance should not be null or 0
      //   // 2. amount type has string 'credit' or 'debit' THEN:

      //   //Create a new Transaction object
      final newTransaction = new Transactions(
        customerId: newCustomerId, //Foreign Key
        type: _type!.toLowerCase(),
        amount: _balance!,
        created_date: createdDate,
        time: time,
        balance: _balance!,
      );

      //Add Transaction object into new Customer's Transaction Table
      await DbHelper.instance.addTransaction(newTransaction);
      ref.invalidate(transactionListProvider);
    }

    //Refresh Customer List in UI
    ref.invalidate(customerListProvider);

    // Show SnackBar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$_name added into Database")));

    //Navigate to MyCustomers Screen
    ref.read(navigationProvider.notifier).state = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Customer Name
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  onSaved: (newValue) {
                    _name = newValue;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length > 50) {
                      return "Please enter valid customer name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Customer Name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(200),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //Phone number
                TextFormField(
                  onSaved: (newValue) {
                    _phone = newValue;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 10 ||
                        value.trim().length > 10) {
                      return "Please enter 10 digits valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(200),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //Row with Dynamic Size
                LayoutBuilder(
                  builder: (ctx, constraints) {
                    return Row(
                      children: [
                        //Amount
                        SizedBox(
                          width:
                              (constraints.maxWidth * 0.5) -
                              (constraints.maxWidth * 0.02),
                          child: TextFormField(
                            controller: _balanceController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            // initialValue: "0",
                            onSaved: (newValue) {
                              //if new value is null return null, if tryParse return null, then return 0 (double)
                              _balance = double.tryParse(newValue ?? '') ?? 0;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Amount";
                              }
                              if (double.tryParse(value) == null) {
                                return "Only numbers allowed";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Amount",
                              prefixText: "Rs. ",
                              // hintText: "0",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.04),

                        //Amount Type
                        SizedBox(
                          width:
                              (constraints.maxWidth * 0.5) -
                              (constraints.maxWidth * 0.02),
                          child: ToggleCreditDebit(
                            onChange: (value) {
                              _type =
                                  value; //Later - implement in AddTransaction
                            },
                            isAmountNotNull:
                                (double.tryParse(_balanceController.text) ??
                                    0) !=
                                0,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),

                //Save Button
                SizedBox(
                  width: double.infinity,

                  child: OutlinedButton(
                    onPressed: _onSave,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
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
