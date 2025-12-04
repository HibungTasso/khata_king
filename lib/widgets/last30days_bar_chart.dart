import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:khata_king/models/daily_summary.dart';

class Last30DaysBarChart extends StatelessWidget {
  final List<DailySummary> data;
  final bool isSevenDays;

  const Last30DaysBarChart({
    super.key,
    required this.data,
    this.isSevenDays = false,
  });

  String formatNumber(double value) {
    if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(0)}K";
    }
    return value.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    double maxY = 0;
    for (var d in data) {
      if (d.credit > maxY) maxY = d.credit;
      if (d.debit > maxY) maxY = d.debit;
    }

    double interval = maxY <= 1000
        ? 200
        : maxY <= 5000
        ? 500
        : maxY <= 15000
        ? 2000
        : 5000;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        maxY: maxY + interval,
        barGroups: _buildBars(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: interval,
              getTitlesWidget: (value, meta) {
                if (value == meta.max) return const SizedBox.shrink();
                return Text(
                  formatNumber(value),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt() - 1;

                // Completely block FLChart from generating extra X values
                if (index < 0 || index >= data.length) {
                  return const SizedBox.shrink();
                }

                return _label(data[index].day);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(int day) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(day.toString(), style: const TextStyle(fontSize: 10)),
    );
  }

  List<BarChartGroupData> _buildBars() {
    return List.generate(data.length, (i) {
      return BarChartGroupData(
        x: i + 1,
        barsSpace: 1,
        barRods: [
          // CHANGE 1 → Made width fatter (change here to adjust)
          BarChartRodData(toY: data[i].credit, width: 5, color: Colors.red),

          // CHANGE 1 → Same width for debit bar
          BarChartRodData(toY: data[i].debit, width: 5, color: Colors.green),
        ],
      );
    });
  }
}
