import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/api/api_constants.dart';
import 'package:flutter_shopping_list_app/api/api_service.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:flutter_shopping_list_app/pages/new_item_page.dart';
import 'package:flutter_shopping_list_app/widgets/grocery_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // _loadItems();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    print(_error);

    Widget content = const Center(
      child: Text(
        'No items added yet.',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = GroceryList(
        groceryItems: _groceryItems,
        removeItem: _removeItem,
      );
    }

    if (_error != null) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            size: 60,
          ),
          const SizedBox(
            width: double.infinity,
            height: 10,
          ),
          Text(
            _error!,
            style: const TextStyle(fontSize: 20),
          ),
        ],
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

  Future<void> _getData() async {
    final data = await ApiService().getItems();

    if (ApiService.error != '') {
      setState(() {
        _error = ApiService.error;
      });
    }

    setState(() {
      _groceryItems = data!;
      _isLoading = false;
    });
  }

  Future<void> _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItemPage(),
      ),
    );

    if (newItem == null) return;

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  Future<void> _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      ApiConstants.url,
      '${ApiConstants.shopingListEndpoint}/${item.id}.json',
    );
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }
}
