import 'package:cloud_firestore/cloud_firestore.dart';
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
        hunger: doc.data['hunger'] ?? 60
      );
    }).toList();
  }

  // get users stream
  Stream <List<Users>> get users {
    return userCollection.snapshots().map(_usersListFromSnapshot);
  }

}