import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khata_king/db/db_helper.dart';

class SyncService {
  //instantiate singleton db
  final db = DbHelper.instance;
  final firestore = FirebaseFirestore.instance;

  //current user id
  final uid = FirebaseAuth.instance.currentUser!.uid;

  //Sync Data
  Future<void> syncData() async {
    // 1. Read Local data
    final customers = await db.getCustomers();
    final transactions = await db.getTransactions();

    //Firestore current user reference (pointer to Parent Collection)
    final userRef = firestore.collection("users").doc(uid);

    // 2. Sync Customer
    for (var c in customers) {
      /*
        Add data to sub collection
        if doesn't exist, then create a new one
        else overide or just add
      */
      await userRef.collection('customers').doc(c.id.toString()).set({
        'name': c.name,
        'phone': c.phone,
        'created_date': c.created_date,
        'time': c.time,
        'balance': c.balance,
      });
    }

    //3. Sync Transaction
    for (var t in transactions) {
      await userRef.collection('transactions').doc(t.id.toString()).set({
        'customer_id': t.customerId,
        'type': t.type,
        'amount': t.amount,
        'note': t.note,
        'created_date': t.created_date,
        'time': t.time,
        'balance': t.balance,
      });
    }
  }
}
