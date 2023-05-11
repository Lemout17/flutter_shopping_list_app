import 'dart:convert';

import 'package:flutter_shopping_list_app/api/api_constants.dart';
import 'package:flutter_shopping_list_app/data/data.dart';
import 'package:flutter_shopping_list_app/models/grocery.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String? error = '';

  Future<List<GroceryItem>?> getItems() async {
    try {
      final url = Uri.https(
        ApiConstants.url,
        '${ApiConstants.shopingListEndpoint}.json',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.body == 'null') return [];

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

        return loadedItems;
      }

      if (response.statusCode >= 400) {
        error = 'Failed to fetch data.Please try again later.';
      }
    } catch (e) {
      error = e.toString();
    }
    return null;
  }
}
