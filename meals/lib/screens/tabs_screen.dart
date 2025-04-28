import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import 'package:meals/models/meal.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>>? _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Lista de Categorias', 'screen': CategoriesScreen()},
      {'title': 'Meus Favoritos', 'screen': FavoriteScreen(widget.favoriteMeals)},
    ];
  }


  _selectedState(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens![_selectedScreenIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _screens![_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedState,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}
