import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/models/category.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';

class Constants {
  static Map<Categories, Category> categories = {
    Categories.vegetables: const Category(
      'Vegetables',
      Color.fromARGB(255, 0, 255, 128),
    ),
    Categories.fruit: const Category(
      'Fruit',
      Color.fromARGB(255, 145, 255, 0),
    ),
    Categories.meat: const Category(
      'Meat',
      Color.fromARGB(255, 255, 102, 0),
    ),
    Categories.dairy: const Category(
      'Dairy',
      Color.fromARGB(255, 0, 208, 255),
    ),
    Categories.carbs: const Category(
      'Carbs',
      Color.fromARGB(255, 0, 60, 255),
    ),
    Categories.sweets: const Category(
      'Sweets',
      Color.fromARGB(255, 255, 149, 0),
    ),
    Categories.spices: const Category(
      'Spices',
      Color.fromARGB(255, 255, 187, 0),
    ),
    Categories.convenience: const Category(
      'Convenience',
      Color.fromARGB(255, 191, 0, 255),
    ),
    Categories.hygiene: const Category(
      'Hygiene',
      Color.fromARGB(255, 149, 0, 255),
    ),
    Categories.other: const Category(
      'Other',
      Color.fromARGB(255, 0, 225, 255),
    ),
  };

  static List<GroceryItem> groceryItems = [
    GroceryItem(
        id: 'a',
        name: 'Milk',
        quantity: 1,
        category: categories[Categories.dairy]!),
    GroceryItem(
        id: 'b',
        name: 'Bananas',
        quantity: 5,
        category: categories[Categories.fruit]!),
    GroceryItem(
        id: 'c',
        name: 'Beef Steak',
        quantity: 1,
        category: categories[Categories.meat]!),
  ];
}
