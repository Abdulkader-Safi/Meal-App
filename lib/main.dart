import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_sceen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 132, 0, 52),
        ),
        useMaterial3: true,
      ),
      home: const CategoriesScreen(),
    );
  }
}
