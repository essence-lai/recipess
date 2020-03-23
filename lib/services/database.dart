import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipess/modals/ingredient.dart';
import 'package:recipess/modals/instruction.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/modals/users.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference User collection
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

  // collection reference recipe
  final CollectionReference recipeCollection = Firestore.instance.collection('recipes');

  Future updateRecipeData( String name, String description, List<Ingredient> ingredients, List<Instruction> instructions, int servings, int calories, int prepTime, int cookTime ) async {
    var uuid = Uuid();
    List<Object> listOfIngredients = ingredients.map((ingredient) => {
      'index' : ingredient.index,
      'amount': ingredient.amount,
      'unit' : ingredient.unit,
      'ingredient': ingredient.ingredient
    }).toList();

    List<Object> listOfInstructions = instructions.map((instruction) => {
      'index': instruction.index,
      'description' : instruction.description
    }).toList();

      return await recipeCollection.document(uuid.v4()).setData({
        'name': name,
        'description': description,
        'ingredients': listOfIngredients,
        'instructions': listOfInstructions,
        'servings': servings,
        'calories': calories,
        'prepTime': prepTime,
        'cookTime': cookTime
      });
    }
}