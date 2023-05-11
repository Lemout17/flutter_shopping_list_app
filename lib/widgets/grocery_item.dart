import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/models/category.dart';

class GroceryListItem extends StatelessWidget {
  final String id;
  final String name;
  final int quantity;
  final Category category;
  const GroceryListItem({
    super.key,
    required this.name,
    required this.id,
    required this.quantity,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name.substring(0, 1).toUpperCase() + name.substring(1),
      ),
      leading: CircleAvatar(
        maxRadius: 20,
        backgroundColor: category.color,
        child: Text(
          name.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      trailing: Text(
        quantity.toString(),
      ),
    );
  }
}
