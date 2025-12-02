import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String img;

  const RecipeImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        img,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}