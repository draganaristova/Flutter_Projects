import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final bool passed = exam.date.isBefore(now);
    final cardColor = passed ? Colors.yellow.shade200 : Colors.green.shade50;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: exam);
      },
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: passed ? Colors.yellow.shade300 : Colors.green.shade100, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                exam.name,
                style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
               SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}