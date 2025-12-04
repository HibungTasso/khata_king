import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:khata_king/providers/customer_providers.dart';

final dbHelperProvider = Provider<DbHelper>((ref) {
  return DbHelper.instance; //Singleton DBHelper instance
});

//All Transaction List Provider
final transactionListProvider = FutureProvider<List<Transactions>>((ref) async {
  final db = ref.read(dbHelperProvider);

  return db.getTransactions();
});

//Get Transactions by transaction id
final getTransactionsByCustomerIdProvider =
    FutureProvider.family<List<Transactions>, int>((ref, id) {
      final db = ref.read(dbHelperProvider);

      return db.getTransactionByCustomerId(id);
    });

//Delete All transactions
final deleteAllTransactionsProvider = FutureProvider<void>((ref) {
  final db = ref.read(dbHelperProvider);

  db.deleteAllTransactions();
});

//total Credits
final totalCreditsProvider = Provider<double>((ref) {
  final allTransactions = ref.watch(transactionListProvider);
  late bool customerHadCreditBefore;

  return allTransactions.when(
    data: (allTransactions) {
      double totalCredits = 0;

      for (var t in allTransactions) {
        if (t.type == 'credit') {
          totalCredits += t.amount;
        } else if (t.type == 'debit') {
          //Check if current customer had credit beore
          customerHadCreditBefore = allTransactions.any((x) {
            final xid = x.id;
            final tid = t.id;

            if (xid == null || tid == null) return false;

            return x.customerId == t.customerId &&
                x.type == 'credit' &&
                xid < tid; // older than current transaction
          });

          // Only subtract if this debit is "returning" previous credit
          if (customerHadCreditBefore) {
            totalCredits -= t.amount;
          }
        }
      }

      return totalCredits;
    },

    loading: () => 0.00,
    error: (error, stackTrace) => 0.00,
  );
});

//total Debits +++++CHANGE LATER++++++
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

//Current Customer total balance
final getCustomerBalanceByIdProvider = FutureProvider.family<double, int>((
  ref,
  id,
) async {
  final db = ref.read(dbHelperProvider);

  // get customer
  final customer = await db.getCustomerById(id);

  // if null return 0
  if (customer == null) return 0.0;

  return customer.balance; // or customer.totalAmount
});

//Delete Transaction by transaction id
final deleteTransactionByIdProvider = FutureProvider.family<int, int>((
  ref,
  transactionId,
) {
  final db = ref.read(dbHelperProvider);

  final a = db.deleteTransactionById(transactionId);

  //Refresh UI
  ref.invalidate(transactionListProvider);
  ref.invalidate(totalCreditsProvider);
  ref.invalidate(totalDebitsProvider);
  ref.invalidate(customerListProvider);

  return a;
});
