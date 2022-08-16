import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mod_app/constants/db_collections.dart';
import 'package:flutter_mod_app/core/models/user_data.dart';

class ProfileRepository {
  static final ProfileRepository _profileRepository =
      ProfileRepository._internal();
  static FirebaseFirestore db = FirebaseFirestore.instance;

  factory ProfileRepository() {
    return _profileRepository;
  }

  ProfileRepository._internal();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String email) {
    final docRef = db.collection(DataBaseCollections.users).doc(email);
    return docRef.snapshots();
  }

  void setInfo(String email, UserData data) {
    db
        .collection(DataBaseCollections.users)
        .doc(email)
        .set(data.toMap(), SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserMap(String email) async {
    try {
      final docRef = db.collection(DataBaseCollections.users).doc(email);
      final doc = await docRef.get();
      final data = doc.data();
      return data;
    } catch (e) {
      return null;
    }
  }

  Future<void> addUserInfo(UserData data) async {
    db.collection(DataBaseCollections.users).add(data.toMap());
  }
}
