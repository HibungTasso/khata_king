class Customers {
  Customers({
    this.id,
    required this.name,
    required this.phone,
    required this.created_date,
    required this.balance,
  });

  int? id;
  String name;
  String phone;
  String created_date;
  double balance;

  //Customer Object -> Database Map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> newMap = {};

    if (id != null) {
      //Database auto generates Id, so we should not send
      //custom id to database,
      //It checks if we are working with Existing id
      newMap['id'] = id;
    }

    newMap['name'] = name;
    newMap['phone'] = phone;
    newMap['created_date'] = created_date;
    newMap['balance'] = balance;

    return newMap;
  }

  //Database Map -> Customer Object
  factory Customers.fromMap(Map<String, dynamic> dbMap) {
    //converting from Database Map to newMap
    final Map<String, dynamic> newMap = {
      'id': dbMap['id'],
      'name': dbMap['name'],
      'phone': dbMap['phone'],
      'created_date': dbMap['created_date'],
      'balance': dbMap['balance']
    };

    return Customers(
      id: newMap['id'] as int?,
      name: newMap['name'] as String,
      phone: newMap['phone'] as String,
      created_date: newMap['created_date'] as String,
      balance: (newMap['balance'] as num).toDouble(),
    );
  }
}
