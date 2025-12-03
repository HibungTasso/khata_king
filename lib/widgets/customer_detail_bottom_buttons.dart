import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/widgets/add_transaction.dart';

class CustomerDetailBottomButtons extends StatelessWidget {
  const CustomerDetailBottomButtons({super.key, required this.customer});

  final Customers customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // YOU GOT
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddTransaction(isCredit: false, customer: customer)));
              },
              child: Ink(
                color: Colors.green.withAlpha(180),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward_sharp, color: Colors.green),
                    Text("You Got", style: GoogleFonts.inter(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),

          // YOU GAVE
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddTransaction(isCredit: true, customer: customer)));
              },
              child: Ink(
                height: 60,
                color: Colors.red.withAlpha(180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_upward_sharp, color: Colors.red),
                    Text("You Gave", style: GoogleFonts.inter(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
