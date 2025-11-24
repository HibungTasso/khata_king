import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalCredits = 2500;
    final double todayEarning = 1050;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            //Total Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Total Credits
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          "Total Credits",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Rs. $totalCredits",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                //Today's Earning
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          "Today's Earning",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Rs. $todayEarning",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            //Transactions History
            //____Later show last 3-5 transaction in mini container____
            SizedBox(
              width: double.infinity,
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history),
                        SizedBox(width: 10),
                        Text(
                          "Transaction History",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            //Monthly Analitics
            SizedBox(
              width: double.infinity,
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                clipBehavior: Clip.hardEdge,

                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.analytics_sharp),
                        SizedBox(width: 10),
                        Text(
                          "Montly Analytics",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
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
