import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/favorite_provider.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/screens/categories_sceen.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/meal_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    if (identifier == 'filters') {
      Navigator.of(context).pop();

      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(
            currentFilter: _selectedFilters,
          ),
        ),
      )
          .then(
        (value) {
          setState(() {
            _selectedFilters = value ?? kInitialFilters;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final List<Meal> availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }

      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeal: availableMeals,
    );
    var activePageTitle = 'Pick your category';

    if (_selectedPageIndex == 1) {
      final List<Meal> _favoriteMeal = ref.watch(favoritesMealProvider);

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
        );
      }
      activePageTitle = "Favorite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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
