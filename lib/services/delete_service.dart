import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/providers/customer_providers.dart';
import 'package:khata_king/providers/transaction_provider.dart';

class DeleteService {
  //Instantiate Singleton db
  final firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  //Delete Data from Firestore
  Future<void> deleteData(WidgetRef ref) async {
    //Parent Collection
    final userRef = firestore.collection('users').doc(uid);

    //1. Delete all customers from firestore
    final customers = await userRef
        .collection("customers")
        .get(); //reference of all the data
    for (var doc in customers.docs) {
      await doc.reference.delete();
    }

    //2. Delete all transactions from firestore
    final transactions = await userRef.collection("transactions").get();
    for (var doc in transactions.docs) {
      await doc.reference.delete();
    }

    //3. Delete all customers and transactions from local storage
    ref.read(deleteAllCustomersProvider);
    ref.read(deleteAllTransactionsProvider);

    //Refresh Customer Transaction lists
    ref.invalidate(customerListProvider);
    ref.invalidate(transactionListProvider);
  }
}
