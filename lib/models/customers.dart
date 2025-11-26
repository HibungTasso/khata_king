class Customers {
  Customers({
    this.id,
    required this.name,
    required this.phone,
    required this.created_date,
    required this.balance,
    required this.time
  });

  int? id;
  String name;
  String phone;
  String created_date;
  String time;
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

    newMap['name'] = this.name;
    newMap['phone'] = this.phone;
    newMap['created_date'] = this.created_date;
    newMap['time'] = this.time;
    newMap['balance'] = this.balance;

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
      'time': dbMap['time'],
      'balance': dbMap['balance']
    };

    return Customers(
      id: newMap['id'] as int?,
      name: newMap['name'] as String,
      phone: newMap['phone'] as String,
      created_date: newMap['created_date'] as String,
      time: newMap['time'],
      balance: (newMap['balance'] as num).toDouble(),
    );
  }
}
