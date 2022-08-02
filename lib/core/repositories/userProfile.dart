import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mod_app/core/models/user_data.dart';

class ProfileRepository {
  static final ProfileRepository _profileRepository =
      ProfileRepository._internal();
  static FirebaseFirestore db = FirebaseFirestore.instance;

  factory ProfileRepository() {
    return _profileRepository;
  }

  ProfileRepository._internal();

  void listenUser(String email, Function callback) {
    final docRef = db.collection("users").doc(email);
    docRef.snapshots().listen(
          (event) => callback(event.data()),
        );
  }

  void setInfo(String email, UserData data) {
    db
        .collection("users")
        .doc(email)
        .set(data.toMap(), SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserMap(String email) async {
    try {
      final docRef = db.collection("users").doc(email);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      return data;
    } catch (e) {
      return null;
    }
  }

  UserData getUserDataFromMap(Map<String, dynamic> map) {
    String email = map["email"];
    String? nick = map["nick"];
    String? name = map["name"];
    String? surname = map["surname"];
    String? age = map["age"];
    String? city = map["city"];
    String? avatarUrl = map["avatarUrl"];
    return UserData(email, nick, name, surname, age, city, avatarUrl);
  }

  void addInfo(UserData data) {
    db.collection("users").add(data.toMap()).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
