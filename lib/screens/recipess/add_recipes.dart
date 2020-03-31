import 'package:flutter/material.dart';
import 'package:recipess/modals/ingredient.dart';
import 'package:recipess/modals/instruction.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/services/database.dart';
import 'package:recipess/shared/constants.dart';
import 'package:recipess/shared/loading.dart';
import 'package:provider/provider.dart';


class AddRecipes extends StatefulWidget {
  @override
  _AddRecipesState createState() => _AddRecipesState();
}

class _AddRecipesState extends State<AddRecipes> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String description;
  int servings;
  int calories;
  List<Instruction> instructions = new List<Instruction>();
  List<Ingredient> ingredients = new List<Ingredient>();
  int prepTime;
  int cookTime;

  List<Widget> listOfInstructionFields = <Widget>[];
  int instructionIndex = 1;
  String instructionError = '';

  List<Widget> listOfIngredientFields = <Widget>[];
  int ingredientIndex = 1;
  String ingredientError = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
     didChangeDependencies();

  
    final user = Provider.of<User>(context);

    return loading ? Loading() : Scaffold(
        backgroundColor: Color(0xffECFAF0),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.green[400],
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                title: Text('Create a Recipe',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Champagne",
                      fontWeight: FontWeight.bold
                      )),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                      color: Colors.white.withOpacity(0.10),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: [
                            ...<Widget>[
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Recipe Name'),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a name' : null,
                                onChanged: (val) {
                                  setState(() => name = val);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Recipe Description'),
                                keyboardType: TextInputType.multiline,
                                maxLength: 200,
                                maxLines: 5,
                                validator: (val) =>
                                    val.isEmpty ? 'Tell us about it!' : null,
                                onChanged: (val) {
                                  setState(() => description = val);
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text('Ingredients',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.green[600],fontWeight: FontWeight.w600, fontFamily: "Champagne"),),
                            ],
                            ...listOfIngredientFields,
                            ...<Widget>[
                              SizedBox(height: 20.0),
                              ListTile(
                                leading: listOfIngredientFields.length > 1 ? 
                                  OutlineButton(
                                          shape: StadiumBorder(),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 20.0),
                                          highlightColor: Colors.greenAccent,
                                          splashColor: Colors.greenAccent,
                                          textColor: Colors.green[600],
                                          highlightedBorderColor: Colors.white,
                                          child: Text('Add an Ingredient',
                                              style: TextStyle(fontSize: 14)),
                                          onPressed: () {
                                            setState(() {
                                              listOfIngredientFields.add(SizedBox(height: 20.0));
                                              listOfIngredientFields.add( Text('Ingredient $ingredientIndex',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14, color: Colors.green[400])));
                                            listOfIngredientFields.add(SizedBox(height: 10.0));

                                            listOfIngredientFields
                                                .add( TextFormField(
                                                  decoration: textInputDecoration.copyWith( hintText: 'Name'),
                                                  keyboardType:
                                                      TextInputType.text,
                                                      validator: (val) => val.isEmpty ? 'Name': null,
                                                  onChanged: (val) {
                                                    final Ingredient currentIngredient = ingredients.firstWhere((ingredient) => ingredient.index == ingredientIndex,orElse: () => null);
                                                    
                                                    if (currentIngredient != null) {
                                                      setState(() => { currentIngredient.ingredient = val, });
                                                    } else {
                                                      setState(() => ingredients.add(Ingredient(index: ingredientIndex, ingredient: val)));
                                                    }
                                                  },
                                                ));
                                              listOfIngredientFields.add(SizedBox(height: 10.0));
                                              listOfIngredientFields.add(
                                                TextFormField(
                                                  decoration: textInputDecoration
                                                      .copyWith(
                                                          hintText:
                                                              'Amount'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (val) => val.isEmpty
                                                      ? 'Amount'
                                                      : null,
                                                  onChanged: (val) {
                                                    final Ingredient currentIngredient = ingredients.firstWhere((ingredient) => ingredient.index == ingredientIndex,orElse: () => null);
                                                    
                                                    int amount = int.tryParse(val);

                                                    if (currentIngredient != null) {
                                                      setState(() => {
                                                            currentIngredient.amount = amount,
                                                          });
                                                    } else {
                                                      setState(() => ingredients.add(Ingredient(index: ingredientIndex, amount: amount)));
                                                    }
                                                  },
                                                ),
                                              );

                                              listOfIngredientFields.add(SizedBox(height: 10.0));

                                              listOfIngredientFields.add(
                                                TextFormField(
                                                  decoration: textInputDecoration
                                                      .copyWith(
                                                          hintText:
                                                              'Unit'),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (val) => val.isEmpty
                                                      ? 'Unit'
                                                      : null,
                                                  onChanged: (val) {
                                                    final Ingredient currentIngredient = ingredients.firstWhere((ingredient) => ingredient.index == ingredientIndex,orElse: () => null);

                                                    if (currentIngredient != null) {
                                                      setState(() => {
                                                            currentIngredient.unit = val,
                                                          });
                                                    } else {
                                                      setState(() => ingredients.add(Ingredient(index: ingredientIndex, unit: val)));
                                                    }
                                                  },
                                                ),
                                              );
                                              ingredientIndex++;
                                            });
                                          },
                                  ): null,
                                title: listOfIngredientFields.length > 1
                                    ? null
                                    : OutlineButton(
                                        shape: StadiumBorder(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 50.0),
                                        highlightColor: Colors.greenAccent,
                                        splashColor: Colors.greenAccent,
                                        textColor: Colors.green[600],
                                        highlightedBorderColor: Colors.white,
                                        child: Text('Add an Ingredient',
                                            style: TextStyle(fontSize: 14)),
                                        onPressed: () {
                                          setState(() {
                                            listOfIngredientFields.add(SizedBox(height: 20.0));
                                            listOfIngredientFields.add( Text('Ingredient $ingredientIndex',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 14, color: Colors.green[400])));
                                           
                                            listOfIngredientFields.add(SizedBox(height: 10.0));

                                            listOfIngredientFields
                                                .add( TextFormField(
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                        hintText:
                                                            'Name'),
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (val) => val.isEmpty
                                                    ? 'Name'
                                                    : null,
                                                onChanged: (val) {
                                                  final Ingredient currentIngredient = ingredients.firstWhere((ingredient) => ingredient.index == ingredientIndex,orElse: () => null);
                                                  
                                                  if (currentIngredient != null) {
                                                    setState(() => {
                                                          currentIngredient.ingredient = val,
                                                        });
                                                  } else {
                                                    setState(() => ingredients.add(Ingredient(index: ingredientIndex, ingredient: val)));
                                                  }
                                                },
                                              ));
                                            listOfIngredientFields.add(SizedBox(height: 10.0));
                                            listOfIngredientFields.add(
                                              TextFormField(
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                        hintText:
                                                            'Amount'),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (val) => val.isEmpty
                                                    ? 'Amount'
                                                    : null,
                                                onChanged: (val) {
                                                  final Ingredient currentIngredient = ingredients.firstWhere((ingredient) => ingredient.index == ingredientIndex,orElse: () => null);
                                                  
                                                  int amount = int.tryParse(val);

                                                  if (currentIngredient != null) {
                                                    setState(() => {
                                                          currentIngredient.amount = amount,
                                                        });
                                                  } else {
                                                    setState(() => ingredients.add(Ingredient(index: ingredientIndex, amount: amount)));
                                                  }
                                                },
                                              ),
                                            );

                                            listOfIngredientFields.add(SizedBox(height: 10.0));

                                            listOfIngredientFields.add(
                                               TextFormField(
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                        hintText:
                                                            'Unit'),
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (val) => val.isEmpty
                                                    ? 'Unit'
                                                    : null,
                                                onChanged: (val) {
                                                  final Ingredient currentIngredient = ingredients.firstWhere((ingredient) => ingredient.index == ingredientIndex,orElse: () => null);

                                                  if (currentIngredient != null) {
                                                    setState(() => {
                                                          currentIngredient.unit = val,
                                                        });
                                                  } else {
                                                    setState(() => ingredients.add(Ingredient(index: ingredientIndex, unit: val)));
                                                  }
                                                },
                                              ),
                                            );
                                            ingredientIndex++;
                                          });
                                        },
                                      ),
                                trailing: listOfIngredientFields.length > 1 ?
                                  OutlineButton(
                                          shape: StadiumBorder(),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 20.0),
                                          highlightColor: Colors.redAccent,
                                          splashColor: Colors.redAccent,
                                          textColor: Colors.red,
                                          highlightedBorderColor: Colors.white,
                                          child: Text('Remove an Ingredient',
                                              style: TextStyle(fontSize: 14)),
                                          onPressed: () {
                                            setState(() {
                                              ingredients.removeWhere(
                                                  (ingredient) =>
                                                      ingredient.index ==
                                                      (ingredientIndex - 1));
                                              for(var i = 0; i < 8; i++){ 
                                                listOfIngredientFields.removeLast();
                                               }
                                            
                                              ingredientIndex--;
                                            });
                                          },
                                        )
                                      : null,                             
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                ingredientError,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                              SizedBox(height: 20.0),
                              Text('Recipe Steps',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.green[600], fontWeight: FontWeight.w600, fontFamily: "Champagne")),
                            ],
                            ...listOfInstructionFields,
                            ...<Widget>[
                              SizedBox(height: 20.0),
                              ListTile(
                                leading: listOfInstructionFields.length > 1
                                    ? OutlineButton(
                                        shape: StadiumBorder(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 40.0),
                                        highlightColor: Colors.greenAccent,
                                        splashColor: Colors.greenAccent,
                                        textColor: Colors.green[600],
                                        highlightedBorderColor: Colors.white,
                                        child: Text('Add a Step',
                                            style: TextStyle(fontSize: 14)),
                                        onPressed: () {
                                          setState(() {
                                            listOfInstructionFields
                                                .add(SizedBox(height: 20.0));
                                            listOfInstructionFields.add(
                                              TextFormField(
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                        hintText:
                                                            'Step $instructionIndex'),
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLength: 150,
                                                maxLines: 3,
                                                validator: (val) => val.isEmpty
                                                    ? 'Describe your step'
                                                    : null,
                                                onChanged: (val) {
                                                  final Instruction
                                                      currentInstruction =
                                                      instructions.firstWhere(
                                                          (instruction) =>
                                                              instruction
                                                                  .index ==
                                                              instructionIndex,
                                                          orElse: () => null);

                                                  if (currentInstruction !=
                                                      null) {
                                                    setState(() => {
                                                          currentInstruction
                                                                  .description =
                                                              val,
                                                        });
                                                  } else {
                                                    setState(() => instructions
                                                        .add(Instruction(
                                                            index:
                                                                instructionIndex,
                                                            description: val)));
                                                  }
                                                },
                                              ),
                                            );
                                            instructionIndex++;
                                          });
                                        },
                                      )
                                    : null,
                                title: listOfInstructionFields.length > 1
                                    ? null
                                    : OutlineButton(
                                        shape: StadiumBorder(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 50.0),
                                        highlightColor: Colors.greenAccent,
                                        splashColor: Colors.greenAccent,
                                        textColor: Colors.green[600],
                                        highlightedBorderColor: Colors.white,
                                        child: Text('Add a Step',
                                            style: TextStyle(fontSize: 14)),
                                        onPressed: () {
                                          setState(() {
                                            listOfInstructionFields
                                                .add(SizedBox(height: 20.0));
                                            listOfInstructionFields.add(
                                              TextFormField(
                                                decoration: textInputDecoration
                                                    .copyWith(
                                                        hintText:
                                                            'Step $instructionIndex'),
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLength: 150,
                                                maxLines: 3,
                                                validator: (val) => val.isEmpty
                                                    ? 'Describe your step'
                                                    : null,
                                                onChanged: (val) {
                                                  final Instruction
                                                      currentInstruction =
                                                      instructions.firstWhere(
                                                          (instruction) =>
                                                              instruction
                                                                  .index ==
                                                              instructionIndex,
                                                          orElse: () => null);

                                                  if (currentInstruction !=
                                                      null) {
                                                    setState(() => {
                                                          currentInstruction
                                                                  .description =
                                                              val,
                                                        });
                                                  } else {
                                                    setState(() => instructions
                                                        .add(Instruction(
                                                            index:
                                                                instructionIndex,
                                                            description: val)));
                                                  }
                                                },
                                              ),
                                            );
                                            instructionIndex++;
                                          });
                                        },
                                      ),
                                trailing: listOfInstructionFields.length > 1
                                    ? OutlineButton(
                                        shape: StadiumBorder(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 30.0),
                                        highlightColor: Colors.redAccent,
                                        splashColor: Colors.redAccent,
                                        textColor: Colors.red,
                                        highlightedBorderColor: Colors.white,
                                        child: Text('Remove a Step',
                                            style: TextStyle(fontSize: 14)),
                                        onPressed: () {
                                          setState(() {
                                            instructions.removeWhere(
                                                (instruction) =>
                                                    instruction.index ==
                                                    (instructionIndex - 1));
                                            listOfInstructionFields
                                                .removeLast();
                                            listOfInstructionFields
                                                .removeLast();
                                            instructionIndex--;
                                          });
                                        },
                                      )
                                    : null,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                instructionError,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                              SizedBox(height: 20.0),
                              Text('Good to Knows',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.green[600], fontWeight: FontWeight.w600, fontFamily: "Champagne")),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Number of Servings'),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a number' : null,
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  int servingsVal = int.tryParse(val);
                                  setState(() => servings = servingsVal);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Calories'),
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  int caloriesVal = int.tryParse(val);
                                  setState(() => calories = caloriesVal);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Prep Time (mins)'),
                                validator: (val) =>
                                  val.isEmpty ? 'Enter a number' : null,
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  int prepVal = int.tryParse(val);
                                  setState(() => prepTime = prepVal);
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Cook Time (mins)'),
                                validator: (val) =>
                                  val.isEmpty ? 'Enter a number' : null,
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  int cookVal = int.tryParse(val);
                                  setState(() => cookTime = cookVal);
                                },
                              ),
                              SizedBox(height: 30.0),
                              FloatingActionButton(
                                child: Icon(Icons.add, color: Colors.white),
                                backgroundColor: Colors.pinkAccent,
                                onPressed: () async {
                                  if (instructions.length < 3) {
                                    setState(() {
                                      instructionError =
                                          'Please add at least 3 steps';
                                    });
                                    return;
                                  }
                                  
                                  if (ingredients.length < 3) {
                                    setState((){
                                      ingredientError = 'Please add at least 3 ingredients';
                                    });
                                    return;
                                  }
                                  
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                  
                                    Navigator.of(context).pop();
                                    await DatabaseService(uid: user.uid).updateRecipeData(
                                    name ?? name.toLowerCase(),
                                    description ?? description, 
                                    ingredients ?? ingredients, 
                                    instructions ?? instructions, 
                                    servings ?? servings,
                                    calories ?? calories,
                                    prepTime ?? prepTime,
                                    cookTime ?? cookTime);

                                  }
                                },
                              )
                            ],
                          ])));
                },
                childCount: 1,
              ),
            )
          ],
        ));
  }
}
