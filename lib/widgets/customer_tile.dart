import 'package:flutter/material.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.name,
    required this.balance,
    required this.phone,
  });

  final String name;
  final double balance;
  final String phone;

  @override
  Widget build(BuildContext context) {
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
        
          //onTap
          onTap: () {},

          //onLongPress (DELETE option)
          onLongPress: (){},
          
        ),
      ),
    );
  }
}
