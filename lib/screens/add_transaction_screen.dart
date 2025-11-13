import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  String type = "income";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Transaction Title",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter title",
              ),
            ),

            const SizedBox(height: 20),

            // Amount
            const Text(
              "Amount",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter amount",
              ),
            ),

            const SizedBox(height: 20),

            // Type selection
            const Text(
              "Type",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                Radio(
                  value: "income",
                  groupValue: type,
                  onChanged: (v) {
                    setState(() => type = v!);
                  },
                ),
                const Text("Income"),

                Radio(
                  value: "expense",
                  groupValue: type,
                  onChanged: (v) {
                    setState(() => type = v!);
                  },
                ),
                const Text("Expense"),
              ],
            ),

            const SizedBox(height: 30),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // UI-only → Just go back
                  Navigator.pop(context);
                },
                child: const Text("Save Transaction"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
