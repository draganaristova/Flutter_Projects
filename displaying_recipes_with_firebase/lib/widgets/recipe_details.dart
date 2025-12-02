import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text(
          'Instructions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        Text(recipe.instructions.isNotEmpty ? recipe.instructions : 'No instructions available'),
        const SizedBox(height: 15),
        const Text(
          'Ingredients',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        ...recipe.ingredients.map((ing) => Text('- $ing')).toList(),
        const SizedBox(height: 15),
        if (recipe.youtube.isNotEmpty)
          TextButton(
            onPressed: () {
              // YouTube link so url_launcher
            },
            child: const Text('Watch on YouTube'),
          ),
      ],
    );
  }
}