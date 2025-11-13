import 'package:displaying_recipes/screens/details.dart';
import 'package:displaying_recipes/screens/home.dart';
import 'package:displaying_recipes/screens/meals.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Recipes App'),
        "/meals": (context) => MealsPage(),
        "/details": (context) => DetailsRecipeMeals(),
      },
    );
  }
}

