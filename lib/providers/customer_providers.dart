import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/models/customers.dart';


//dbHelper Provider
final dbHelperProvider = Provider<DbHelper>((ref){
  return DbHelper.instance; //use this Singleton DBHelper instance throughtout the app
});

//All Customer List Provider
final customerListProvider = FutureProvider<List<Customers>>((ref) async{
  //Access DBHelper instance (one time only)
  final db = ref.read(dbHelperProvider);

  //call getCustomers() form DBHelper 
  return db.getCustomers();
});

//Customer with Id Provider
final customerByIdProvider = FutureProvider.family<Customers?, int>(  //It takes 1 int parameter
  (ref, customerId){  //taking 1 extra parameter for customerId
    final db = ref.read(dbHelperProvider);
    
    return db.getCustomerById(customerId);
  }
);