import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> deletePost({
    required String postid,
  }) async {
    try {
      var a = await firestore.collection("post").doc(postid).get();
      if (a.exists) {
        await firestore.collection("post").doc(postid).delete();
        return 1;
      } else {
        return 3;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<bool> deletereport({
    required String id,
  }) async {
    try {
      await firestore.collection("report").doc(id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addcate({
    required File image,
    required String name,
  }) async {
    try {
      final metadata = SettableMetadata(contentType: 'image/png');
      final imageRef = storage.ref().child("images/${DateTime.now()}");
      await imageRef.putFile(image, metadata);
      final String imageurl = await imageRef.getDownloadURL();

      DocumentReference docref = await firestore.collection('category').doc();
      String docid = docref.id;
      docref.set({
        "id": docid,
        "image": imageurl,
        "name": name,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteaddmin({
    required String id,
  }) async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      user!.delete();
      await firestore.collection("user").doc(id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletecate({
    required String cateid,
  }) async {
    try {
      await firestore.collection("category").doc(cateid).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> addCategory({
    required String name,
    required File image,
  }) async {
    try {
      CollectionReference collectionReference =
          firestore.collection('category');
      DocumentReference documentReference = collectionReference.doc();
      String docID = documentReference.id;

      final metadata = SettableMetadata(contentType: 'image/png');
      final imageRef = storage.ref().child("images/${DateTime.now()}");

      await imageRef.putFile(image, metadata);
      final String imageurl = await imageRef.getDownloadURL();

      await documentReference.set({
        "id": docID,
        "name": name,
        "image": imageurl,
      });
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> addadmin({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user!.uid.isEmpty) {
        return false;
      }
      String newadd = result.user!.uid;
      CollectionReference collectionReference = firestore.collection('user');
      DocumentReference documentReference = collectionReference.doc(newadd);
      String docID = documentReference.id;

      await documentReference.set({
        "id": docID,
        "name": name,
        "email": email,
        "password": password,
        "role": "admin",
      });
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getcategory() async {
    QuerySnapshot snapshot = await firestore.collection("category").get();
    var result = snapshot.docs.map((doc) => doc.data()).toList();
    return result;
  }

  Future<List<dynamic>> getallpost() async {
    QuerySnapshot snapshot = await firestore.collection("post").get();
    var result = snapshot.docs.map((doc) => doc.data()).toList();
    return result;
  }
}
