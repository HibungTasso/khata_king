import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:khata_king/models/daily_summary.dart';
import 'package:khata_king/providers/transaction_provider.dart';

/*--- 30 DAYS ---*/
//Filter Transactions for last 30 days
final last30DaysTransactionsProvider = Provider<List<Transactions>>((ref) {
  final all = ref.watch(transactionListProvider);

  return all.when(
    data: (list) {
      final today = DateTime.now();
      final startDate = today.subtract(Duration(days: 30));

      return list.where((t) {
        // Convert "dd/mm/yyyy" to DateTime
        final parts = t.created_date.split('/');
        final day = int.parse(parts[0]); //Extract day from created_date
        final month = int.parse(parts[1]); //Extract month from created_date
        final year = int.parse(parts[2]); //Extract year from created_date
        final transDate = DateTime(year, month, day);

        return transDate.isAfter(startDate) &&
            transDate.isBefore(today.add(Duration(days: 1)));
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

//Total Credits - last 30days
final last30DaysTotalCreditsProvider = Provider<double>((ref) {
  final transactions = ref.watch(last30DaysTransactionsProvider);

  double totalCredits = 0;

  final filterCredits = transactions.where((listItem) {
    if (listItem.type == "credit") {
      return true;
    }
    return false;
  }).toList();

  for (var t in filterCredits) {
    totalCredits += t.amount;
  }

  return totalCredits;
});

//Total Debits - last 30days
final last30dDaysTotalDebitsProvider = Provider<double>((ref){
  final transactions = ref.watch(last30DaysTransactionsProvider);

  final filterDebits = transactions.where((listItem){
    if(listItem.type == "debit"){
      return true;
    }
    return false;
  });

  double totalDebits = 0;

  for(var t in filterDebits){
    totalDebits += t.amount;
  }

  return totalDebits;
});

//Last 30 Days Summary provider
final last30DaysSummaryProvider = Provider<List<DailySummary>>((ref) {
  final transactions = ref.watch(last30DaysTransactionsProvider);

  final today = DateTime.now();
  final startDate = today.subtract(
    Duration(days: 29),
  ); // 30 days including today

  // Prepare 30 empty days summary
  List<DailySummary> summary = List.generate(30, (index) {
    final date = startDate.add(Duration(days: index));
    return DailySummary(day: date.day, credit: 0, debit: 0);
  });

  // Fill summary using transaction data
  for (var t in transactions) {
    // Convert "dd/mm/yyyy" to DateTime
    final parts = t.created_date.split('/');
    final d = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    final y = int.parse(parts[2]);
    final transDate = DateTime(y, m, d);

    // Find difference between transaction date and startDate
    final index = transDate.difference(startDate).inDays;

    // If transaction not within valid range, skip
    if (index < 0 || index >= 30) continue;

    // Add credit OR debit to the correct day
    if (t.type == 'credit') {
      summary[index] = DailySummary(
        day: summary[index].day,
        credit: summary[index].credit + t.amount,
        debit: summary[index].debit,
      );
    } else if (t.type == 'debit') {
      summary[index] = DailySummary(
        day: summary[index].day,
        credit: summary[index].credit,
        debit: summary[index].debit + t.amount,
      );
    }
  }

  return summary;
});



/*--- 7 DAYS ---*/
// Last 7 Days - Raw Transactions
final last7DaysTransactionsProvider = Provider<List<Transactions>>((ref) {
  final all = ref.watch(transactionListProvider);

  return all.when(
    data: (list) {
      final today = DateTime.now();
      final startDate = today.subtract(const Duration(days: 7));

      return list.where((t) {
        // Convert "dd/mm/yyyy" to DateTime
        final parts = t.created_date.split('/');
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        final transDate = DateTime(year, month, day);

        // Include only between last 7 days
        return transDate.isAfter(startDate) &&
            transDate.isBefore(today.add(const Duration(days: 1)));
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// Last 7 Days - Summary for Chart
final last7DaysSummaryProvider = Provider<List<DailySummary>>((ref) {
  final transactions = ref.watch(last7DaysTransactionsProvider);

  final today = DateTime.now();
  final startDate = today.subtract(const Duration(days: 6)); // total 7 days

  // Create summary list for 7 days
  List<DailySummary> summary = List.generate(7, (index) {
    final date = startDate.add(Duration(days: index));
    return DailySummary(day: date.day, credit: 0, debit: 0);
  });

  // Fill summary with transaction data
  for (var t in transactions) {
    final parts = t.created_date.split('/');
    final d = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    final y = int.parse(parts[2]);
    final transDate = DateTime(y, m, d);

    final index = transDate.difference(startDate).inDays;

    if (index < 0 || index >= 7) continue;

    if (t.type == 'credit') {
      summary[index] = DailySummary(
        day: summary[index].day,
        credit: summary[index].credit + t.amount,
        debit: summary[index].debit,
      );
    } else if (t.type == 'debit') {
      summary[index] = DailySummary(
        day: summary[index].day,
        credit: summary[index].credit,
        debit: summary[index].debit + t.amount,
      );
    }
  }

  return summary;
});


//Total Credits - last 7days
final last7DaysTotalCreditsProvider = Provider<double>((ref){
  final transactions = ref.watch(last7DaysTransactionsProvider);
  final filterCredits = transactions.where((itemList){
    if(itemList.type == "credit"){
      return true;
    }
    return false;
  });

  double totalCredits = 0;
  for(var t in filterCredits){
    totalCredits += t.amount;
  }
  
  return totalCredits;
});


//Total Debits - last 7days
final last7DaysTotalDebitsProvider = Provider<double>((ref){
  final transactions = ref.watch(last7DaysTransactionsProvider);
  final filterDebits = transactions.where((itemList){
    if(itemList.type == "debit"){
      return true;
    }
    return false;
  });

  double totalDebits = 0;
  for(var t in filterDebits){
    totalDebits += t.amount;
  }
  
  return totalDebits;
});










