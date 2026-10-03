import 'package:plantdisese/ui/models/brew.dart';
import 'package:plantdisese/ui/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('users');

  Future<void> updateUserData(String fname, String lname, String email) async {
    return await brewCollection.document(uid).setData({
      'firstname': fname,
      'lastname': lname,
      'email': email,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Brew(
        firstname: doc.data['firstname'] ?? '',
        lastname: doc.data['lastname'] ?? 0,
        email: doc.data['email'] ?? '0'
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstname: snapshot.data['firstname'],
      lastname: snapshot.data['lastname'],
      email: snapshot.data['email']
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}