import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/transactions.dart';

final dbHelperProvider = Provider<DbHelper>((ref){
  return DbHelper.instance; //Singleton DBHelper instance
});

//All Transaction List Provider
final transactionListProvider = FutureProvider<List<Transactions>>((ref) async{
  final db = ref.read(dbHelperProvider);

  return db.getTransactions();
});

//Get Customer id with Transaction