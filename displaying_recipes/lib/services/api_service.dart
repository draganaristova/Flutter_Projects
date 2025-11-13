import 'package:displaying_recipes/models/category.dart';
import 'package:displaying_recipes/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService{
  Future<List<Category>> loadCategory() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categoriesJson = data['categories'] ?? [];
      final categoryList = categoriesJson.map((e) =>
          Category.fromJson(e as Map<String, dynamic>)).toList();

      return categoryList;
    }
    else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }

    Future<Category?> searchCategoryByName(String name) async {
      if (name.isEmpty) return null;
      final List<Category> all = await loadCategory();
      try {
        return all.firstWhere(
                (c) => c.name.toLowerCase() == name.toLowerCase());
      } catch (e) {
        return null;
      }
    }


    Future<List<Recipe>> loadMealsByCategory(String category) async{
      final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));

      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final List<dynamic> mealsJson = data['meals'] ?? [];

        return mealsJson.map((data) => Recipe (
          id: int.parse(data['idMeal']),
          name: data['strMeal'],
          img: data['strMealThumb'],
          instructions: '',
          ingredients: [],
          youtube: '',
        )).toList();
      }
      else{
        throw Exception('Failed to load meals from category $category');
      }
    }
    
    Future<List<Recipe>> searchMeals(String query) async{
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final List<dynamic> mealsJson = data['meals'] ?? [];
      return mealsJson.map((e) => Recipe.fromJson(e)).toList();
    }
    return [];
    }
    
    Future<Recipe> loadRandomRecipe() async{
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return Recipe.fromJson(data['meals'][0]);
    }
    throw Exception('Failed to load random recipe');
    }

  Future<Recipe> loadRecipeById(int id) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealJson = data['meals'] != null && data['meals'].isNotEmpty
          ? data['meals'][0] as Map<String, dynamic>
          : null;
      if (mealJson != null) {
        return Recipe.fromJson(mealJson);
      } else {
        throw Exception('Recipe not found');
      }
    } else {
      throw Exception('Failed to load recipe: ${response.statusCode}');
    }
  }
  }