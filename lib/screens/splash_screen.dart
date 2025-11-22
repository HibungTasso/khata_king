import 'package:flutter/material.dart';
import 'package:khata_king/db/db_helper.dart';
import 'package:khata_king/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> initializeDB() async{
    //load database
    await DbHelper.instance.database;

    //additional waiting time
    // await Future.delayed(Duration(seconds: 2));
  }


  Widget build(BuildContext context){
    return FutureBuilder(
      //Future input
      future: initializeDB(),

      //listen to future and rebuild the UI
      builder: (ctx, snapshot){
        //Check if future is waiting
        if(snapshot.connectionState ==ConnectionState.waiting){
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 252, 251, 237),
            body: Center(
              child: Image.asset(
                "assets/images/splash_loading.gif",
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        //When Loading completes -> go to Navigation
        return Navigation();
      },
    );
  }
}