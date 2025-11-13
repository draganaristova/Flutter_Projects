import 'package:flutter/material.dart';
import 'package:homework_exam_schedule/widgets/exam_card.dart';
import '../models/exam_model.dart';

class ExamGrid extends StatefulWidget{
  final List<Exam> exam;

  const ExamGrid({super.key, required this.exam});


  @override
  State<StatefulWidget> createState() => _ExamGridState();
}

class _ExamGridState extends State<ExamGrid> {
  @override
  Widget build(BuildContext context) {
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 4 / 5,
      ),
      itemCount: widget.category.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(category: widget.category[index]);
      },
    );
  }
}

