import 'package:flutter/material.dart';

class ToggleCreditDebit extends StatefulWidget {
  const ToggleCreditDebit({
    super.key,
    required this.onChange,
    required this.isAmountNotNull,
  });

  //onChange Function
  final Function(String) onChange;

  //Amount entered checker
  final bool isAmountNotNull;

  @override
  State<ToggleCreditDebit> createState() {
    return _ToggleCreditDebitState();
  }
}

class _ToggleCreditDebitState extends State<ToggleCreditDebit> {
  //by default type = Credit
  bool isCredit = true;

  //Initial  Widget
    final activeWidget = Stack(
      children: [
        // Animation Layer
        //Dynamic slider size
        LayoutBuilder(
          builder: (ctx, constraints) {
            return AnimatedAlign(
              //Meta data
              alignment: Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),

              //Slider UI
              child: Container(
                width: constraints.maxWidth / 2, //Dynamic UI Slider
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        // Credit and Debit Text Layer
        Row(
          children: [
            // CREDIT (You Gave)
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    "You Gave",

                  ),
                ),
              ),
            ),

            // DEBIT (You Got)
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    "You Got",
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

  @override
  Widget build(BuildContext context) {

    widget.onChange('credit');

    //Background
    return Opacity(
      opacity: widget.isAmountNotNull ? 1 : 0.4,
      child: Container(
        height: 58,
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),

        child: widget.isAmountNotNull? Stack(
          children: [
            // Animation Layer
            //Dynamic slider size
            LayoutBuilder(
              builder: (ctx, constraints) {
                return AnimatedAlign(
                  //Meta data
                  alignment: isCredit
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: const Duration(milliseconds: 200),

                  //Slider UI
                  child: Container(
                    width: constraints.maxWidth / 2, //Dynamic UI Slider 50%
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Credit and Debit Text Layer
            Row(
              children: [
                // CREDIT (You Gave)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCredit = true;
                      });
                      widget.onChange("credit"); //Notify Parent -> in AddCustomerScreen
                    },
                    child: Center(
                      child: Text(
                        "You Gave",
                        style: isCredit
                            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )
                            : Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    ),
                  ),
                ),

                // DEBIT (You Got)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCredit = false;
                      });
                      widget.onChange("debit"); //Notify Parent -> in AddScreenScreen
                    },
                    child: Center(
                      child: Text(
                        "You Got",
                        style: isCredit
                            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )
                            : Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ): activeWidget,
      ),
    );
  }
}
