import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_king/widgets/last30days_bar_chart.dart';
import 'package:khata_king/providers/analytics_provider.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  int selectedRange = 7;

  @override
  Widget build(BuildContext context) {
    final summary = selectedRange == 7
        ? ref.watch(last7DaysSummaryProvider)
        : ref.watch(last30DaysSummaryProvider);

    final totalCredits = selectedRange == 7
        ? ref.watch(last7DaysTotalCreditsProvider)
        : ref.watch(last30DaysTotalCreditsProvider);
    final totalDebits = selectedRange == 7
        ? ref.watch(last7DaysTotalDebitsProvider)
        : ref.watch(last30dDaysTotalDebitsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: summary.isEmpty
            ? const Center(child: Text("No transactions available"))
            : Column(
                children: [
                  // TOGGLE BUTTON
                  // =======================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _toggleButton("Weekly", 7),
                      const SizedBox(width: 12),
                      _toggleButton("Monthly", 30),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // LEGEND
                  // =======================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text("You Got", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "You Gave",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // CHART
                  // =======================
                  Container(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Last30DaysBarChart(
                      data: summary,
                      isSevenDays: selectedRange == 7,
                    ),
                  ),
                  SizedBox(height: 12),

                  //Total Credits
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Text
                        Expanded(
                          child: Text(
                            "Total amount you gave",
                            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),

                        //Amount
                        Text("Rs. $totalCredits", style: GoogleFonts.inter()),
                      ],
                    ),
                  ),
                  SizedBox(height: 2),

                  //Total Debits
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Text
                        Expanded(
                          child: Text(
                            "Total amount you got back",
                            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),

                        //Amount
                        Text("Rs. $totalDebits", style: GoogleFonts.inter()),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Toggle Button Builder
  Widget _toggleButton(String text, int value) {
    final isActive = selectedRange == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRange = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
