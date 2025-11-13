import 'package:displaying_recipes/models/recipe.dart';
import 'package:displaying_recipes/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsRecipeMeals extends StatelessWidget {
  const DetailsRecipeMeals({super.key});

  @override
  Widget build(BuildContext context) {
    final Recipe meal = ModalRoute.of(context)!.settings.arguments as Recipe;
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                meal.img,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              meal.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 15),
            Text(
              'Ingredients: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: meal.ingredients
                  .map(
                    (ing) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '- $ing',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 15),
            Text(
              'Instructions: ',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(meal.instructions),
            SizedBox(height: 10),
            Text('Youtube chanel: ',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            Text(meal.youtube),
          ],
        ),
      ),
    );
  }
}
