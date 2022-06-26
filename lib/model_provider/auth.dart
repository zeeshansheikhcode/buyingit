/**
 * This File contain code of Provider Authentication 
 * With Function 
 * Login
 * Create Account
 * Log Out
 */
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Auth with ChangeNotifier
{
  // A file with Authentication Functions
  final storage = const FlutterSecureStorage();
  String? Email;    
  String? createrIDvalue; 
  String? _userId;
  String? get userId 
  { 
   return _userId = createrIDvalue;
  }
  String errorMessage = '';
 final  FirebaseAuth _auth = FirebaseAuth.instance;
 final  FirebaseFirestore  firestore = FirebaseFirestore.instance;
 
  //Function Of Sign Up
   Future<bool> createAccount(String name,String email,String password,String phoneNo,String url) async
{    
       
    try
     {  
        User? user  = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
        if(user!=null)
        {
          user.updateProfile(displayName: name,);

          await firestore.collection('users').doc(_auth.currentUser!.uid).set(
            {
                          'username' :    name,
                           'password':    password,
                           'email'   :    email,
                           'phone_no':    phoneNo,
                          'photoUrl' :    url,
                           'status'  :    "offline",
                            'uid'    :    _auth.currentUser!.uid,
            });
            notifyListeners();
            return true;
        }
        else
        {
          print('Account creation Failed');
          return false;
        }
       

     } on FirebaseAuthException
     catch(e)
     {
        print(e.code);
        switch(e.code)
        {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
          errorMessage = "User disabled.";
          break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
          errorMessage = "Too many requests to log into this account.";
          break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
          errorMessage = "Server error, please try again later.";
          break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
          errorMessage = "Email address is invalid.";
          break;
          default:
          errorMessage = "Signup failed. Please try again.";
          break;
        }
        return false;
     }
}
// Function Of Login
Future<bool> logIn(String email,String password) async
{  
  
   try
   {  
     User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user; 
     if( _auth.currentUser?.uid == null && user!.uid==null)
     {  
       //print(_auth.currentUser?.uid);
       return false;
     }
     else
     { print('logged');
       await 
       firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((value) => user!.updateProfile(displayName: value['username'],));
       Email = _auth.currentUser!.email;
       await storage.write(key: "userId", value: user!.uid);
       createrIDvalue = await storage.read(key: "userId");
       await storage.write(key: "sellby", value: email);
       notifyListeners();
       //print('Login Failed');
     }
     return true;
   } on FirebaseAuthException
   catch(e)
   {
     switch (e.code) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        errorMessage = "Wrong password ";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        errorMessage = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        errorMessage = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        errorMessage = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        errorMessage = "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        errorMessage = "Email address is invalid.";
        break;
      default:
        errorMessage = "Login failed. Please try again.";
        break;
    }
    
     return false;
   }
 }
 //Function to Log Out
   Future logOut (BuildContext context) async
  {
    FirebaseAuth auth = FirebaseAuth.instance;
   try
   { 
   
     await auth.signOut();
     await storage.delete(key: "userId");
     notifyListeners();
    
   }
   catch(e) 
   {
   print(e);
   }
  }
}

