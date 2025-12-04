import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Firebase Singleton DB
final firebaseAuthProvider = Provider<FirebaseAuth>((ref){
  return FirebaseAuth.instance;
});

//Stream (continuous) to listen if user is logged in or not 
final authStateProvider = StreamProvider<User?>((ref){
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

//Sign Up
final signUpProvider = Provider((ref){
  //it should return an anonymous function to sign up new user to firebase DB
  return (String email, String password) async{
    await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(email: email, password: password);
  };
});

//Login/Sign In
final signInProvider = Provider((ref){
  //returns annonymous function to sign in user
  return (String email, String password) async{
    await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(email: email, password: password);
  };
});

//Logout
final logoutProvider = Provider((ref){
  //returns annonymous function to logout, with no parameters 
  return () async{
    await ref.read(firebaseAuthProvider).signOut();
  };
});