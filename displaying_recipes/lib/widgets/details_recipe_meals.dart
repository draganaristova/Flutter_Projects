import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_title.dart';
import '../widgets/recipe_image.dart';
import '../widgets/recipe_details.dart';

class DetailsRecipeMeals extends StatelessWidget {
  const DetailsRecipeMeals({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecipeImage(img: recipe.img),
            const SizedBox(height: 15),
            RecipeTitle(name: recipe.name),
            RecipeDetails(recipe: recipe),
          ],
        ),
      ),
    );
  }
}
