import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories_sceen.dart';
import 'package:meal_app/screens/meal_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showInfoMessage('Remove ${meal.title} from favorite list');
      return;
    }

    setState(() {
      _favoriteMeal.add(meal);
    });
    _showInfoMessage('Add ${meal.title} to favorite list');
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Pick your category';

    if (_selectedPageIndex == 1) {
      if (_favoriteMeal.isEmpty) {
        activePage = const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                "No food found in your favorite list \nAdd food to your favorites list by clicking star icon on the top",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      } else {
        activePage = MealsScreen(
          meals: _favoriteMeal,
          onToggleFavorite: _toggleMealFavoriteStatus,
        );
      }
      activePageTitle = "Favorite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
