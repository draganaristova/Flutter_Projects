import 'package:flutter/material.dart';
import 'package:homework_exam_schedule/screens/details.dart';
import 'package:homework_exam_schedule/screens/home.dart';

import 'models/exam_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред за испити - 223085',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellowAccent.shade100,
        )
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: "Распоред за испити - 223085"),
      },
      onGenerateRoute: (settings){
        if(settings.name == "/details"){
          final exam = settings.arguments;
          if(exam is Exam){
            return MaterialPageRoute(builder: (context) => DetailsPage(exam: exam),
            );
          }
        }
        return null;
      },
    );
  }
}

