import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy transaction list
    final transactions = [
      {"title": "Milk Sale", "amount": "+₹120", "type": "income"},
      {"title": "Electricity Bill", "amount": "-₹800", "type": "expense"},
      {"title": "Snacks Sale", "amount": "+₹250", "type": "income"},
      {"title": "Petrol", "amount": "-₹500", "type": "expense"},
      {"title": "Cold Drinks Sale", "amount": "+₹90", "type": "income"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final t = transactions[index];
          final isIncome = t["type"] == "income";

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isIncome ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t["title"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  t["amount"]!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isIncome ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
