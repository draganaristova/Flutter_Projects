import 'package:flutter/material.dart';
import 'package:displaying_recipes_with_firebase/models/category.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import '../services/cart_service.dart';
import 'addToCart.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
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
    final category =
    ModalRoute.of(context)!.settings.arguments as Category;
    final meals = await ApiService().loadMealsByCategory(category.name);

    setState(() {
      _meals = meals;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final category =
    ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search meals ...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 6,
                  childAspectRatio: 300 / 480,
                ),
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];
                  return GestureDetector(
                    onTap: () async {
                      final fullRecipe =
                      await ApiService().loadRecipeById(meal.id);
                      Navigator.pushNamed(
                          context, "/details",
                          arguments: fullRecipe);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.green.shade100, width: 2),
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
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    meal.name,
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (CartService().cartItems.contains(meal)) {
                                      CartService().removeRecipe(meal);
                                    } else {
                                      CartService().addRecipe(meal);
                                    }
                                  });
                                },
                                icon: Icon(
                                  CartService().cartItems.contains(meal)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: CartService().cartItems.contains(meal)
                                      ? Colors.red
                                      : null,
                                ),
                              ),
                            ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddToCartScreen(cartItems: CartService().cartItems),
            ),
          );
        },
        backgroundColor: Colors.green.shade400,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            const Icon(Icons.shopping_cart, size: 30),
            if (CartService().cartItems.isNotEmpty)
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.yellow,
                child: Text(
                  '${CartService().cartItems.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
