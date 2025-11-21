import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/navigation_provider.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  ConsumerState<AddCustomerScreen> createState() {
    return _AddCustomerState();
  }
}

class _AddCustomerState extends ConsumerState<AddCustomerScreen> {
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
    final created_date = "${today.day}/${today.month}/${today.year}";

    //New Customer object
    final customer = Customers(
      name: _name!,
      phone: _phone!,
      created_date: created_date,
      balance: 0,
    );

    //Insert into DB/DB table
    DbHelper.instance.addCustomer(customer);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$_name added into Database"))
    );

    //Refresh customerListProvider
    ref.invalidate(customerListProvider);

    //Pop to Dashboard 
    ref.read(navigationProvider.notifier).state=0;
    
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
