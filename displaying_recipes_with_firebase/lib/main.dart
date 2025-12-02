import 'package:displaying_recipes_with_firebase/screens/details.dart';
import 'package:displaying_recipes_with_firebase/screens/home.dart';
import 'package:displaying_recipes_with_firebase/screens/meals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings);

  await notificationsPlugin.initialize(initSettings);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Recipes App'),
        "/meals": (context) => MealsPage(),
        "/details": (context) => DetailsRecipeMeals(),
      },
    );
  }
}
