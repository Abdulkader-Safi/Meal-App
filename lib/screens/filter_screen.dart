import 'package:flutter/material.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          if (identifier == 'meals') {
            Navigator.of(context).pop();

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const TabsScreen(),
              ),
            );
          }
        },
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
