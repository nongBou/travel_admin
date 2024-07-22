import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_admin/models/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<int> logout() async {
    try {
      await auth.signOut();
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<List<dynamic>?> getUsers() async {
    try {
      final result = await firestore.collection("user").get();
      if (result.docs.length > 0) {
        return result.docs;
      }
      return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserModel?> validateToken() async {
    try {
      if (auth.currentUser!.uid.isEmpty) {
        return null;
      } else {
        DocumentSnapshot usersnapshot =
            await firestore.collection("user").doc(auth.currentUser!.uid).get();

        Map<String, dynamic>? userData =
            usersnapshot.data() as Map<String, dynamic>?;
        UserModel user = UserModel.fromMap(userData!);
        print(user.userid);
        return user;
      }
    } catch (e) {
      return null;
    }
  }

  // Future<int> chanagePassword({
  //   required String password,
  //   required String email,
  //   required String newpassword,
  // }) async {
  //   try {
  //     final cred =
  //         EmailAuthProvider.credential(email: email, password: password);
  //     auth.currentUser!.reauthenticateWithCredential(cred).then((value) {
  //       auth.currentUser!.updatePassword(newpassword).then((_) async {
  //         //Success, do something
  //         await firestore.collection("user").doc(auth.currentUser!.uid).update({
  //           "password": newpassword,
  //         });
  //         return 1;
  //       }).catchError((error) {
  //         //Error, show something
  //         return 0;
  //       });
  //     });

  //     return 1;
  //   } catch (e) {
  //     print(e);
  //     return 0;
  //   }
  // }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user!.uid.isNotEmpty) {
        DocumentSnapshot usersnapshot =
            await firestore.collection("user").doc(result.user!.uid).get();
        // print(result.user!.uid);

        Map<String, dynamic>? userData =
            usersnapshot.data() as Map<String, dynamic>?;
        UserModel user = UserModel.fromMap(userData!);
        if (user.role == "admin") {
          return user;
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user!.uid.isEmpty) {
        return 0;
      }
      await firestore.collection("user").doc(result.user!.uid).set({
        "userId": result.user!.uid,
        "email": email,
        "role": "admin",
        "password": password,
      });

      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
