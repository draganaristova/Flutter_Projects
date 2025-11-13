import 'package:flutter/material.dart';
import '../models/exam_model.dart';
import '../widgets/exam_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Exam> exam = [
    Exam(
      name: "Бази на податоци",
      date: DateTime(2025, 11, 20, 9, 0), //2025, noemvri, 20ti, 9:0h
      rooms: ["Лаб. 200АВ"],
    ),
    Exam(
      name: "Структурно програмирање",
      date: DateTime(2025, 4, 12, 15, 30),
      rooms: ["Лаб. 215"],
    ),
    Exam(
      name: "Мобилни информациски системи",
      date: DateTime(2026, 1, 13, 10, 0),
      rooms: ["Лаб. 138"],
    ),
    Exam(
      name: "Тимски Проект",
      date: DateTime(2026, 2, 14, 12, 0),
      rooms: ["ФИНКИ Амфитеатар"],
    ),
    Exam(
      name: "Веб Програмирање",
      date: DateTime(2025, 1, 25, 18, 0),
      rooms: ["Лаб. 117"],
    ),
    Exam(
      name: "Оперативни системи",
      date: DateTime(2024, 2, 7, 16, 30),
      rooms: ["Лаб. 200А"],
    ),
    Exam(
      name: "Бизнис статистика",
      date: DateTime(2024, 4, 18, 19, 0),
      rooms: ["Барака 1"],
    ),
    Exam(
      name: "Електронска и мобилна трговија",
      date: DateTime(2025, 6, 29, 17, 30),
      rooms: ["Лаб. 215"],
    ),
    Exam(
      name: "Алгоритми и податочни структури",
      date: DateTime(2025, 7, 2, 8, 0),
      rooms: ["Лаб. 138"],
    ),
    Exam(
      name: "Дизајн на интеракција човек-компјутер",
      date: DateTime(2025, 1, 24, 13, 30),
      rooms: ["Лаб. 117"],
    ),
  ];

  @override
  void initState(){
    super.initState();
    exam.sort((a, b) => a.date.compareTo(b.date));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ExamGrid(exam: exam),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Chip(
                avatar: Icon(Icons.list, size: 18),
                label: Text('Вкупно испити: ${exam.length}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}