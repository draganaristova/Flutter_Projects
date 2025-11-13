import 'package:displaying_recipes/models/category.dart';
import 'package:displaying_recipes/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget{
  final List<Category> category;

  const CategoryGrid({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid>{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 200/250
        ),
      itemCount: widget.category.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index){
          return CategoryCard(category: widget.category[index]);
      },
    );
  }
}