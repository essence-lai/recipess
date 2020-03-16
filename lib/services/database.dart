import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/modals/users.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference recipeCollection = Firestore.instance.collection('recipes');
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name, String mood, int hunger) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'mood': mood,
      'hunger': hunger,
    });
  }

  // users list form snapshot

  List<Users> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Users(
        name: doc.data['name'] ?? '',
        mood: doc.data['mood'] ?? 'okay',
        hunger: doc.data['hunger'] ?? 300
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      mood: snapshot.data['mood'],
      hunger: snapshot.data['hunger'],
    );
  }

  // get users stream
  Stream <List<Users>> get users {
    return userCollection.snapshots().map(_usersListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}