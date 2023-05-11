import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:flutter_shopping_list_app/pages/new_item_page.dart';
import 'package:flutter_shopping_list_app/widgets/grocery_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Widget content = const Center(
      child: Text(
        'Try to add some groceries',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (_groceryItems.isNotEmpty) {
      content = GroceryList(
        groceryItems: _groceryItems,
        removeItem: _removeItem,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }

  Future<void> _loadItems() async {
    final url = Uri.https(
      'flutter-grocery-app-d325e-default-rtdb.europe-west1.firebasedatabase.app',
      'shoping-list.json',
    );

    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = Constants.categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == item.value['category'],
          )
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }

    setState(() {
      _groceryItems = loadedItems;
    });
  }

  Future<void> _addItem() async {
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItemPage(),
      ),
    );

    _loadItems();
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }
}
