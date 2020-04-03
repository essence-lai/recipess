
class User {
  
  final String uid;

  User({ this.uid });
}

class UserData {
  final String uid;
  final String name;
  final String mood;
  final int hunger;
  final List<dynamic> favourites;

  UserData({ this.uid, this.name, this.mood, this.hunger, this.favourites });
}