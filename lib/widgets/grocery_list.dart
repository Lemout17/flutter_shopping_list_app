import 'package:flutter/material.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:flutter_shopping_list_app/widgets/grocery_item.dart';

class GroceryList extends StatelessWidget {
  final List<GroceryItem> groceryItems;
  final void Function(GroceryItem) removeItem;
  const GroceryList(
      {super.key, required this.groceryItems, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          removeItem(groceryItems[index]);
        },
        key: ValueKey(groceryItems[index].id),
        child: GroceryListItem(
            id: groceryItems[index].id,
            name: groceryItems[index].name,
            quantity: groceryItems[index].quantity,
            category: groceryItems[index].category),
      ),
      itemCount: groceryItems.length,
    );
  }
}
