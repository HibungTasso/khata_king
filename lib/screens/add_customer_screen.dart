import 'package:flutter/material.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/customers.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddCustomerState();
  }
}

class _AddCustomerState extends State<AddCustomerScreen> {
  //getting ready the data for creating new customer object
  String? _name, _phone;

  //Form Key
  final _formKey = GlobalKey<FormState>();

  //Save Button
  void _onSave() {
    //Check if form is invalid
    if (!_formKey.currentState!.validate()) {
      return;
    }

    //Otherwise save all fields
    _formKey.currentState!.save();

    //Save Current Date and time
    final today = DateTime.now();
    final _created_date = "${today.day}/${today.month}/${today.year}";

    //New Customer object
    final customer = Customers(
      name: _name!,
      phone: _phone!,
      created_date: _created_date,
      balance: 0,
    );

    //Insert into DB/DB table
    DbHelper.instance.addCustomer(customer);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$_name added into Database"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Customer Name
              TextFormField(
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

              //Save Button
              OutlinedButton(onPressed: _onSave, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
