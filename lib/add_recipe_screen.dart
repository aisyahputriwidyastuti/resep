import 'package:flutter/material.dart';
import 'db_helper.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = {
        'name': _nameController.text,
        'preparation_time': _timeController.text,
        'ingredients': _ingredientsController.text,
        'instructions': _instructionsController.text,
      };
      await DBHelper.instance.insertRecipe(recipe);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Recipe Name'),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Preparation Time'),
                validator: (value) => value!.isEmpty ? 'Enter preparation time' : null,
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(labelText: 'Ingredients'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Enter ingredients' : null,
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: InputDecoration(labelText: 'Instructions'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Enter instructions' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
