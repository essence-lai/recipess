class Ingredient {
  final int index;
  int amount;
  String unit;
  String ingredient; 

  Ingredient({ this.index, this.amount, this.unit, this.ingredient });

  Ingredient.fromJson(Map<String, dynamic> json, this.index){
    amount: json['amount'];
    unit: json['unit'];
    ingredient: json['ingredient'];
  }
}