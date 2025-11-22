import 'package:khata_king/models/customers.dart';
import 'package:khata_king/models/transactions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  /*---Making Singleton database---*/
  /* means database and tables will be created only one time at first time opening the app */

  //Make sure the database is opened only once in the whole app
  DbHelper._privateConstructor(); //Prevents outside creation
  static final DbHelper instance =
      DbHelper._privateConstructor(); //instance will be used everywhere (Singleton)

  static Database? _database; //holds the database connection

  /*----------------------------- */


  //Database Getter
  Future<Database> get database async {
    //Singleton database
    //if DB is already opened -> simply return it
    if (_database != null) {
      return _database!;
    }

    //Otherwise Open it
    _database = await _openDB(); //Call _initDB function
    return _database!;
  }

  //Open/Initialize Database
  Future<Database> _openDB() async {
    final appDBPath = await getDatabasesPath(); //Get this app's database path
    final path = join(
      appDBPath,
      'shopkeeper.db',
    ); //Join the new .db with app's database path

    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables, //call create Table Function
    );
  }

  //Create Tables
  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        created_date TEXT NOT NULL,
        balance REAL NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerId INTEGER NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        note TEXT,
        created_date TEXT NOT NULL,
        balance REAL NOT NULL,
        FOREIGN KEY (customerId) REFERENCES customers (id)
      );

    ''');
  }

  /*---CRUD operations (CUSTORMER)---*/
  //Insert customer
  Future<int> addCustomer(Customers customer) async {
    final db = await database;

    final response = await db.insert('customers', customer.toMap());
    return response;
  }

  //Read/Get all customers
  Future<List<Customers>> getCustomers() async {
    final Database db = await database;

    final List<Map<String, dynamic>> results = await db.query('customers');

    final List<Customers> customers = results.map((item) {
      return Customers.fromMap(item);
    }).toList();

    return customers;
  }

  //Update Customer
  Future<int> updateCustomer(Customers customer) async {
    final db = await database;

    return await db.update(
      //prevents SQL injection (like in case of rawQuery or rawUpdate)
      'customers',

      //SQL needs data in Map form
      customer.toMap(),
      where: 'id = ?', //update the row where id=something,
      whereArgs: [customer.id], //this will supply actual value for '?'
    );
  }

  //Delete Customer
  Future<int> deleteCustomer(int id) async {
    final db = await database;

    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }

  //Get Transaction
  Future<Transactions?> getTransactionById(int id) async {
    final db = await database;
    final rows = await db.query(
      'transaction',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (rows.isEmpty) return null;

    //otherwise
    return Transactions.fromMap(rows.first);
  }

  //Add Transaction
  Future<int> addTransaction(Transactions txn) async {
    final db = await database;

    return await db.transaction<int>((txnDb) async {
      // 1) Fetch the related customer first
      final List<Map<String, dynamic>> result = await txnDb.query(
        'customers',
        where: 'id = ?',
        whereArgs: [txn.customerId],
      );

      if (result.isEmpty) {
        throw Exception("Customer not found");
      }

      final customer = Customers.fromMap(result.first);

      // 2) Calculate new balance
      double newBalance;

      if (txn.type.toLowerCase() == 'credit') {
        newBalance = customer.balance + txn.amount;
      } else {
        newBalance = customer.balance - txn.amount;
      }

      // 3) Insert the transaction
      final txnMap = txn.toMap();
      txnMap['balance'] = newBalance; // snapshot balance after this transaction

      final int txnId = await txnDb.insert('transactions', txnMap);

      // 4) Update the customer's balance
      await txnDb.update(
        'customers',
        {'balance': newBalance},
        where: 'id = ?',
        whereArgs: [customer.id],
      );

      return txnId;
    });
  }

  //Delete Transaction
  Future<int> deleteTransaction(int transactionId) async {
    final db = await database;

    return await db.transaction<int>((txnDb) async {
      // 1) Fetch the transaction you are deleting
      final rows = await txnDb.query(
        'transactions',
        where: 'id = ?',
        whereArgs: [transactionId],
      );

      if (rows.isEmpty) {
        throw Exception("Transaction not found");
      }

      final txn = Transactions.fromMap(rows.first);

      // 2) Fetch the related customer
      final customerRows = await txnDb.query(
        'customers',
        where: 'id = ?',
        whereArgs: [txn.customerId],
      );

      if (customerRows.isEmpty) {
        throw Exception("Customer not found");
      }

      final customer = Customers.fromMap(customerRows.first);

      // 3) Correct the balance
      double newBalance;

      if (txn.type.toLowerCase() == 'credit') {
        // credit added money → delete → subtract
        newBalance = customer.balance - txn.amount;
      } else {
        // debit removed money → delete → add back
        newBalance = customer.balance + txn.amount;
      }

      // 4) Delete the transaction
      final deletedCount = await txnDb.delete(
        'transactions',
        where: 'id = ?',
        whereArgs: [transactionId],
      );

      // 5) Update customer's balance
      await txnDb.update(
        'customers',
        {'balance': newBalance},
        where: 'id = ?',
        whereArgs: [customer.id],
      );

      return deletedCount; // number of rows deleted
    });
  }

  //Update Transaction
  Future<int> updateTransaction(Transactions updatedTxn) async {
    final db = await database;

    return await db.transaction<int>((txnDb) async {
      // 1) Load the OLD transaction
      final oldRows = await txnDb.query(
        'transactions',
        where: 'id = ?',
        whereArgs: [updatedTxn.id],
      );

      if (oldRows.isEmpty) {
        throw Exception("Old transaction not found");
      }

      final oldTxn = Transactions.fromMap(oldRows.first);

      // 2) Load the related customer
      final custRows = await txnDb.query(
        'customers',
        where: 'id = ?',
        whereArgs: [oldTxn.customerId],
      );

      if (custRows.isEmpty) {
        throw Exception("Customer not found");
      }

      final customer = Customers.fromMap(custRows.first);

      // 3) Calculate old effect on balance
      double oldEffect = (oldTxn.type.toLowerCase() == 'credit')
          ? oldTxn.amount
          : -oldTxn.amount;

      // 4) Calculate new effect on balance
      double newEffect = (updatedTxn.type.toLowerCase() == 'credit')
          ? updatedTxn.amount
          : -updatedTxn.amount;

      // 5) Net change
      double netChange = newEffect - oldEffect;

      // 6) New customer balance
      double newBalance = customer.balance + netChange;

      // 7) Update transaction row
      final updateMap = updatedTxn.toMap();
      updateMap['balance'] = newBalance; // snapshot

      final updatedCount = await txnDb.update(
        'transactions',
        updateMap,
        where: 'id = ?',
        whereArgs: [updatedTxn.id],
      );

      // 8) Update customer balance
      await txnDb.update(
        'customers',
        {'balance': newBalance},
        where: 'id = ?',
        whereArgs: [customer.id],
      );

      return updatedCount;
    });
  }
}
