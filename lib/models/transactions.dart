class Transaction {
  Transaction({
    this.id,
    required this.customerId,
    required this.type,
    required this.amount,
    required this.note,
    required this.created_date,
    required this.balance,
  });

  int? id;
  int customerId;
  String type;
  double amount;
  String? note;
  String created_date;
  double balance;

  //Transaction object -> Database Map (insert/update)
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> newMap = {};

    if (id != null) {
      //means update
      newMap['id'] = id;
    }
    newMap['customerId'] = customerId;
    newMap['type'] = type;
    newMap['amount'] = amount;
    newMap['note'] = note;
    newMap['created_date'] = created_date;
    newMap['balance'] = balance;

    return newMap;
  }

  //Database Map -> Transaction object
  factory Transaction.fromMap(Map<String, dynamic> dbMap) {
    final Map<String, dynamic> newMap = {
      'id': dbMap['id'],
      'customerId': dbMap['customerId'],
      'type': dbMap['type'],
      'amount': dbMap['amount'],
      'note': dbMap['note'],
      'created_date': dbMap['created_date'],
      'balance': dbMap['balance'],
    };

    return Transaction(
      id: newMap['id'] as int?,
      customerId: newMap['customerId'] as int,
      type: newMap['type'] as String,
      amount: (newMap['amount'] as num).toDouble(),
      note: newMap['note'] as String?,
      created_date: newMap['created_date'] as String,
      balance: (newMap['balance'] as num).toDouble(),
    );
  }
}
