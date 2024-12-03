import 'package:flutter/material.dart';
import 'db_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _recipes = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    final data = await DBHelper.instance.fetchRecipes();
    setState(() {
      _recipes = data;
    });
  }

  void _deleteRecipe(int id) async {
    await DBHelper.instance.deleteRecipe(id);
    _fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep'),
      ),
      body: _recipes.isEmpty
          ? Center(child: Text('No recipes added yet.'))
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return ListTile(
                  title: Text(recipe['name']),
                  subtitle: Text('Prep Time: ${recipe['preparation_time']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteRecipe(recipe['id']),
                  ),
                  onTap: () {
                    // Navigate to detail screen
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addRecipe').then((_) => _fetchRecipes());
        },
      ),
    );
  }
}
