import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/transaction_provider.dart';

class AddTransaction extends ConsumerStatefulWidget {
  AddTransaction({super.key, required this.isCredit, required this.customer});

  final Customers customer;
  final bool isCredit;

  @override
  ConsumerState<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends ConsumerState<AddTransaction> {
  //Amount Controller
  final _amountController = TextEditingController();
  final _noteController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Transaction")),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            //Question
            Align(
              alignment: Alignment.center,
              child: Text(
                "${widget.isCredit ? "How much did you give to ${widget.customer.name}?" : "How much did ${widget.customer.name} give you?"}",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: widget.isCredit ? Colors.red : Colors.green,
                ),
              ),
            ),
            SizedBox(height: 10),

            //Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //Amount
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter Amount";
                      }
                      if (double.tryParse(value) == null) {
                        return "Enter valid amount";
                      }

                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: "Amount",
                      prefix: Text("Rs. "),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.isCredit ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),

                  //Note
                  TextFormField(
                    controller: _noteController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Note [OPTIONAL]",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.isCredit ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            //Save Button
            SizedBox(
              width: 200,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: widget.isCredit ? Colors.red : Colors.green,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //Add Transaction with Customer id
                    final db = DbHelper.instance;

                    //get Latest customer balance from database (to update proper on UI)
                    final freshCustomer = await db.getCustomerById(
                      widget.customer.id!,
                    );
                    final customerCurrentBalance =
                        freshCustomer?.balance ?? 0.00;

                    //Date and time
                    final today = DateTime.now();
                    final date = "${today.day}/${today.month}/${today.year}";
                    final time = DateFormat('hh:mm a').format(today);

                    //calculate balance
                    final _inputAmount =
                        double.tryParse(_amountController.text) ?? 0.0;
                    late double newBalance;
                    if (widget.isCredit) {
                      newBalance = customerCurrentBalance + _inputAmount;
                    } else {
                      newBalance = customerCurrentBalance - _inputAmount;
                    }

                    //Get Note
                    final _inputNote = _noteController.text.trim();

                    final transaction = Transactions(
                      customerId: widget.customer.id!,
                      type: widget.isCredit ? "credit" : "debit",
                      amount: _inputAmount,
                      created_date: date,
                      time: time,
                      note: _inputNote,
                      balance: newBalance,
                    );

                    await db.addTransaction(transaction);
                    await db.updateCustomerBalance(
                      widget.customer.id!,
                      newBalance,
                    );

                    //Refresh All UI
                    ref.invalidate(transactionListProvider);
                    ref.invalidate(customerListProvider);
                    ref.invalidate(totalCreditsProvider);
                    ref.invalidate(totalDebitsProvider);
                    ref.invalidate(
                      getCustomerBalanceByIdProvider(widget.customer.id!),
                    );
                    ref.invalidate(
                      getTransactionsByCustomerIdProvider(widget.customer.id!),
                    );

                    //Show SnackBar
                    if (_inputAmount > 0) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Transaction added"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }

                    //Pop Screen
                    Navigator.of(context).pop();
                  }
                },

                child: Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
