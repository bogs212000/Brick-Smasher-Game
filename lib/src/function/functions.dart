import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/const.dart';
import '../utils/user.model.dart';

class functions {


}

Future<void> addScore(int score) async {
  String? userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  final userRef =
  FirebaseFirestore.instance.collection('users').doc(userEmail);
  // Update the user's score
  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final userDoc = await transaction.get(userRef);
      if (!userDoc.exists) {
        throw Exception("User does not exist!");
      }

      final currentScore =
          userDoc['score'] ?? 0; // Default to 0 if not present
      transaction.update(userRef, {
        'score': currentScore + score, // Increment total score
      });
    });
    Get.snackbar(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      'Notice',
      'Scores has been added.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      isDismissible:
      false, // Make it non-dismissible until login is complete
    );
  } catch (e) {
    print(e);
  }
}

Future<UserModel?> fetchUserData() async {
  try {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data);
      } else {
        print("User data does not exist in Firestore.");
      }
    } else {
      print("No user is logged in.");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
  return null;
}

Future<int> getPlayerRank(setState) async {
  try {
    // Fetch all users and sort them by score in descending order
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('score', descending: true)
        .get();

    // Get the list of documents (players)
    List<QueryDocumentSnapshot> users = querySnapshot.docs;

    // Iterate to find the player's rank
    for (int i = 0; i < users.length; i++) {
      if (users[i].id == FirebaseAuth.instance.currentUser!.email.toString()) {
        // Rank is index + 1 since ranks are 1-based
        print('rank : $i');
        setState((){
          rank = i + 1;
        });
        return i + 1;
      }
    }

    // If player email is not found
    throw Exception("Player not found in the leaderboard.");
  } catch (e) {
    print("Error getting player rank: $e");
    return -1; // Return -1 to indicate an error
  }
}
