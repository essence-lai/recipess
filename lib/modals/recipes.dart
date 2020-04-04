class Recipes {
  final String uid;
  final String name;
  final String description;
  final List<Object> ingredients; 
  final List<Object> instructions;
  final int servings;
  final int calories;
  final int prepTime;
  final int cookTime;
  final String searchKey;

  Recipes({ this.uid, this.name, this.description, this.ingredients, this.instructions, this.servings, this.calories, this.prepTime, this.cookTime, this.searchKey });
}