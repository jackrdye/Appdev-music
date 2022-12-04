import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService( {required this.uid });

  Future updateUserData(String name, String musicService) async {
    final DocumentReference dataReference = FirebaseFirestore.instance.collection('Users').doc(uid);
    DocumentSnapshot userData = await dataReference.get();
    print(userData.data());
    return userData.data();
  }
}