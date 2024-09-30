import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';

class Recipe {
  final String name;
  final String ingredients;
  final String instructions;
  bool isFavorite;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Recipe> recipes = [
    Recipe(
      name: 'Chicken Biryani',
      ingredients: 'Basmati Rice, cilantro,Onions, Biryani masala, Chicken',
      instructions:
          'Half boil rice, take 70% cooked chicke put layers of chicken and rice and top it with cilantro and fried onions',
    ),
    Recipe(
      name: 'Chicken Curry',
      ingredients: 'Chicken, Curry Powder, Coconut Powder',
      instructions: 'Cook chicken with curry powder, add coconut powder.',
    ),
  ];

  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoritesScreen(recipes: recipes)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    recipe: recipe,
                    onToggleFavorite: toggleFavorite,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
