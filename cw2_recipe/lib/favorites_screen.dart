import 'package:flutter/material.dart';
import 'home_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const FavoritesScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes =
        recipes.where((recipe) => recipe.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(child: Text('No favorite recipes added.'))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return ListTile(
                  title: Text(recipe.name),
                );
              },
            ),
    );
  }
}
