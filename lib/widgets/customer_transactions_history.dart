import 'package:flutter/material.dart';

class CustomerTransactionsHistory extends StatelessWidget {
  const CustomerTransactionsHistory({
    super.key,
    required this.date,
    required this.time,
    required this.note,
    required this.amount,
    required this.type,
  });

  final String date;
  final String time;
  final String note;
  final double amount;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      color: Theme.of(context).colorScheme.secondaryContainer.withAlpha(200),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            //Date-Time and note
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Date-Time
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("$date"),
                        SizedBox(width: 2),
                        Text("$time", style: TextStyle(fontSize: 8)),
                      ],
                    ),

                    //Note
                    SizedBox(
                      width: 130,
                      child: Text("${note.trim()}", 
                      style: TextStyle(fontSize: 8),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                child: Text(
                  "Rs. 500",
                  style: TextStyle(color: Colors.green, fontSize: 13),
                ),
              ),
            ),

            //You Gave
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "200",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
