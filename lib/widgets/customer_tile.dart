import 'package:flutter/material.dart';
import 'package:khata_king/models/customers.dart';
import 'package:khata_king/screens/customer_details_screen.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.name,
    required this.balance,
    required this.phone,
    required this.customer
  });

  final String name;
  final double balance;
  final String phone;
  final Customers customer;

  @override
  Widget build(BuildContext context) {

    //Background Container
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        //Styling
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
        
        //Tile
        child: ListTile(
          title: Text(name, style: TextStyle(fontSize: 20),),
          subtitle: Text(phone),
          trailing: Text("Rs. ${balance.toString()}"),
          leading: Icon(Icons.person),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
        
          //onTap
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return CustomerDetailsScreen(customer: customer,);
            }));
          },

          //onLongPress (DELETE option)
          onLongPress: (){},
          
        ),
      ),
    );
  }
}
