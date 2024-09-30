import 'package:flutter/material.dart';
import 'home_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Recipe recipe;
  final Function(Recipe) onToggleFavorite;

  const DetailsScreen(
      {super.key, required this.recipe, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients: ${recipe.ingredients}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Instructions: ${recipe.instructions}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onToggleFavorite(recipe);
                final snackBar = SnackBar(
                  content: Text(recipe.isFavorite
                      ? 'Added to Favorites'
                      : 'Removed from Favorites'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                  recipe.isFavorite ? 'Unmark Favorite' : 'Mark as Favorite'),
            ),
          ],
        ),
      ),
    );
  }
}
