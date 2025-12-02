import 'package:flutter/material.dart';
import '../models/recipe.dart';

class AddToCartScreen extends StatelessWidget {
  final List<Recipe> cartItems;

  const AddToCartScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favourite Recipes')),
      body: cartItems.isEmpty
          ? const Center(child: Text('No items added'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final meal = cartItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: Image.network(
                  meal.img,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  meal.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}