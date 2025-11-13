import 'package:displaying_recipes/models/category.dart';
import 'package:displaying_recipes/screens/details.dart';
import 'package:displaying_recipes/services/api_service.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';

class MealsPage extends StatefulWidget {
  MealsPage({super.key});

  @override
  State<StatefulWidget> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Recipe> _meals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMeals();
    });
  }

  void loadMeals() async {
    final Category category =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Category;
    final meals = await ApiService().loadMealsByCategory(category.name);

    setState(() {
      _meals = meals;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Category category =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Category;
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search meals ...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) async {
                if (value.isEmpty) {
                  loadMeals();
                } else {
                  final meals =
                  await ApiService().searchMeals(value);
                  setState(() {
                    _meals = meals;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 6,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];
                  return GestureDetector(
                      onTap: () async {
                        final fullRecipe = await ApiService().loadRecipeById(
                            meal.id);
                        Navigator.pushNamed(
                            context, "/details", arguments: fullRecipe);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.green.shade100,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                meal.img,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  meal.name,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      );
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
