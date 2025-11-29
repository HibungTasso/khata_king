class Transactions {
  Transactions({
    this.id,
    required this.customerId,
    required this.type,
    required this.amount,
    this.note = '-Notes not provided-',
    required this.created_date,
    required this.time,
    required this.balance,
  });

  int? id;
  int customerId;
  String type;
  double amount;
  String note;
  String created_date;
  String time;
  double balance;

  //Transaction object -> Database Map (insert/update)
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> newMap = {};

    if (id != null) {
      //means update
      newMap['id'] = this.id;
    }
    newMap['customerId'] = this.customerId;
    newMap['type'] = this.type;
    newMap['amount'] = this.amount;
    newMap['note'] = this.note;
    newMap['created_date'] = this.created_date;
    newMap['time'] = this.time;
    newMap['balance'] = this.balance;

    return newMap;
  }

  //Database Map -> Transaction object
  factory Transactions.fromMap(Map<String, dynamic> dbMap) {
    final Map<String, dynamic> newMap = {
      'id': dbMap['id'],
      'customerId': dbMap['customerId'],
      'type': dbMap['type'],
      'amount': dbMap['amount'],
      'note': dbMap['note'],
      'created_date': dbMap['created_date'],
      'time': dbMap['time'],
      'balance': dbMap['balance'],
    };

    return Transactions(
      id: newMap['id'] as int?,
      customerId: newMap['customerId'] as int,
      type: newMap['type'] as String,
      amount: (newMap['amount'] as num).toDouble(),
      note: newMap['note'] as String,
      created_date: newMap['created_date'] as String,
      time: newMap['time'],
      balance: (newMap['balance'] as num).toDouble(),
    );
  }
}
