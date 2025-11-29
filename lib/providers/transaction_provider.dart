import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/transactions.dart';

final dbHelperProvider = Provider<DbHelper>((ref) {
  return DbHelper.instance; //Singleton DBHelper instance
});

//All Transaction List Provider
final transactionListProvider = FutureProvider<List<Transactions>>((ref) async {
  final db = ref.read(dbHelperProvider);

  return db.getTransactions();
});

//Get Transactions by transaction id
final getTransactionsByCustomerIdProvider = FutureProvider.family<List<Transactions>, int>(
  (ref, id) {
    final db = ref.read(dbHelperProvider);

    return db.getTransactionByCustomerId(id);
  },
);

//Delete All transactions
final deleteAllTransactionsProvider = FutureProvider<void>((ref) {
  final db = ref.read(dbHelperProvider);

  db.deleteAllTransactions();
});

//total Credits
final totalCreditsProvider = Provider<double>((ref) {
  final allTransactions = ref.watch(transactionListProvider);

  return allTransactions.when(
    data: (allTransactions) {
      double totalCredits = 0;

      for (var t in allTransactions) {
        if (t.type == 'credit') {
          totalCredits += t.amount;
        }
      }

      return totalCredits;
    },

    loading: () => 0.00,
    error: (error, stackTrace) => 0.00,
  );
});

//total Debits
final totalDebitsProvider = Provider<double>((ref) {
  final allTransactions = ref.watch(transactionListProvider);

  return allTransactions.when(
    data: (allTransactions) {
      double totalDebits = 0;

      for (var t in allTransactions) {
        if (t.type == 'debit') {
          totalDebits += t.amount;
        }
      }

      return totalDebits;
    },

    loading: () => 0.00,
    error: (error, stackTrace) => 0.00,
  );
});
