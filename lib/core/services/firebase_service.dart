import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// Create or update a document
  static Future<void> createOrUpdate({
    required String collection,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    var customMap = {
      "memberIds": [docId]
    };
    data.addEntries(customMap.entries);
    try {
      final ref = firestore.collection(collection).add(data);
      ref.then(
        (value) => print(value.id),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  /// Read a single document
  static Future<Map<String, dynamic>?> readDocument({
    required String collection,
    required String docId,
  }) async {
    final doc = await firestore.collection(collection).doc(docId).get();
    if (doc.exists) return {...doc.data()!, 'id': doc.id};
    return null;
  }

  /// Read all documents in a collection
  static Future<List<Map<String, dynamic>>> readAll({
    required String collection,
  }) async {
    final snapshot = await firestore.collection(collection).get();
    return snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
  }

  Stream<List<Map<String, dynamic>>> listenToUserById(String id, collection) {
    return FirebaseFirestore.instance
        .collection('add_todo')
        .where("memberIds", arrayContains: id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => {
                  ...doc.data(),
                  'id': doc.id,
                })
            .toList();
      } else {
        return [];
      }
    });
  }

  /// Update fields of a document
  static Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collection).doc(docId).update(data);
  }

  /// Delete a document
  static Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    await firestore.collection(collection).doc(docId).delete();
  }
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyBNET5gzsS4RFHHwHTzCv5A7UEO1s9NQPE',
        appId: '1:846790683902:android:74bfe00fab3be2364889af',
        messagingSenderId: '846790683902',
        projectId: 'todotesttask-213ab',
        storageBucket: 'todotesttask-213ab.firebasestorage.app',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyBNET5gzsS4RFHHwHTzCv5A7UEO1s9NQPE',
        appId: '1:846790683902:ios:74bfe00fab3be2364889af',
        messagingSenderId: '846790683902',
        projectId: 'todotesttask-213ab',
        storageBucket: 'todotesttask-213ab.firebasestorage.app',
        iosClientId: '846790683902-abc123def456.apps.googleusercontent.com',
        iosBundleId: 'com.example.todotask',
      );
    }
    throw UnsupportedError('Unsupported platform: ${defaultTargetPlatform}');
  }
}
