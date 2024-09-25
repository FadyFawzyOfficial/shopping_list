import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/grocery_item.dart';
import '../widgets/grocery_list_tile.dart';
import 'new_grocery_view.dart';

class GroceryView extends StatefulWidget {
  const GroceryView({super.key});

  @override
  State<GroceryView> createState() => _GroceryViewState();
}

class _GroceryViewState extends State<GroceryView> {
  List<GroceryItem> groceryList = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: groceryList.isEmpty
          ? const Center(
              child: Text('You got no grocery item, start adding some!'),
            )
          : ListView.builder(
              itemCount: groceryList.length,
              itemBuilder: (context, index) => GroceryListTile(
                groceryItem: groceryList[index],
                onDismissed: () =>
                    setState(() => groceryList.remove(groceryList[index])),
              ),
            ),
    );
  }

  Future<void> _loadItems() async {
    final url = Uri.https(baseUrl, shoppingListPath);

    final response = await http.get(url);

    Map<String, dynamic> listData = json.decode(response.body);
    List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      item.value['id'] = item.key;
      loadedItems.add(GroceryItem.fromMap(item.value));
    }

    setState(() => groceryList = loadedItems);
  }

  void _addItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewGroceryView()),
    );
  }
}
