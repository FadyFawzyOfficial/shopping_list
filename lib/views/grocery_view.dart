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
      body: FutureBuilder(
        future: _loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('You got no grocery item, start adding some!'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final groceryItem = snapshot.data![index];
              return GroceryListTile(
                groceryItem: groceryItem,
                onDismissed: () => _removeItem(groceryItem),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(baseUrl, shoppingListPath);

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data, please try again later.');
    }

    if (response.body == 'null') {
      return [];
    }

    Map<String, dynamic> listData = json.decode(response.body);
    List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      item.value['id'] = item.key;
      loadedItems.add(GroceryItem.fromMap(item.value));
    }

    return loadedItems;
  }

  Future<void> _addItem() async {
    final groceryItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewGroceryView()),
    );

    if (groceryItem != null) {
      setState(() => groceryList.add(groceryItem));
    }
  }

  Future<void> _removeItem(GroceryItem item) async {
    final itemIndex = groceryList.indexOf(item);
    setState(() => groceryList.remove(item));

    final response =
        await http.delete(Uri.https(baseUrl, deleteItem(item.id!)));

    if (response.statusCode >= 400 && mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Failed to delete this item')),
        );
      setState(() => groceryList.insert(itemIndex, item));
    }
  }
}
