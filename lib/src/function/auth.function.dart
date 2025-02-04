
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/auth.wrapper.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore fbStore = FirebaseFirestore.instance;
final String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;

class AuthService {
  Future<void>  forgotPass(String email)async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        'Notice',
        'Link has been sent!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.blueAccent,
        duration: Duration(seconds: 3),
        isDismissible:
        false, // Make it non-dismissible until login is complete
      );
    } catch(e){
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        margin: EdgeInsets.all(10),
        'Login Successful',
        'Welcome back, $email!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      Get.offAll(() => AuthWrapper());
      print("User signed in successfully");
    } on FirebaseAuthException catch (e) {
      print("Error signing in: ${e.message}");
      // You can handle specific errors here, for example:
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided.");
      }
      Get.snackbar(
        'Error', // Title
        '${e.code}', // Message
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
        // Position of Snackbar
        backgroundColor: Colors.red,
        // Background color
        colorText: Colors.white,
        // Text color
        duration: Duration(seconds: 3),
        // Duration the snackbar will show
        icon: Icon(Icons.info,
            color: Colors.white), // Icon to show on the snackbar
      );
    } catch (e) {
      Get.snackbar(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        'Error',
        // Title
        'An unknown error occurred',
        // Message
        snackPosition: SnackPosition.BOTTOM,
        // Position of Snackbar
        backgroundColor: Colors.red,
        // Background color
        colorText: Colors.white,
        // Text color
        duration: Duration(seconds: 3),
        // Duration the snackbar will show
        icon: const Icon(Icons.info,
            color: Colors.white), // Icon to show on the snackbar
      );
      print("An unknown error occurred: $e");
    }
  }

  Future<void> signUp(String email, String password, String username) async {
    try {
      // Create the user in Firebase Authentication
      await auth.createUserWithEmailAndPassword(email: email, password: password);

      // After successful authentication, save user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'role': 'user',
        'email': email,
        'username': username,
        'score': 0,
      });

      // Show success message and navigate to the AuthWrapper screen
      Get.snackbar(
        'Account Created',
        'Welcome, $email!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      Get.offAll(() => AuthWrapper());
      print("User signed up successfully");
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth-specific exceptions
      Get.back();
      Get.snackbar(
        'Error',
        e.message ?? 'Something went wrong!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      print("Error signing up: ${e.message}");
    } catch (e) {
      // Handle other exceptions
      print("An unknown error occurred: $e");
      Get.snackbar(
        'Error',
        'An unknown error occurred!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }



}