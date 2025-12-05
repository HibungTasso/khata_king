import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/navigation.dart';
import 'package:khata_king/providers/auth_provider.dart';
import 'package:khata_king/screens/login_screen.dart';

class AuthWrapper extends ConsumerWidget{
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user){
        /**
         if authStateProvider returns null - means User not logged in
         else user logged in already
         */

        if(user == null){
          return LoginScreen();
        }else{
          return Navigation();
        }
      },

      loading: ()=> Scaffold(body: Center(child: CircularProgressIndicator(),),),
      error: (error, stackTrace) => Scaffold(body: Center(child: Text("Error: $error"),),)
    );
  }
}