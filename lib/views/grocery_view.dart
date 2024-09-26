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
  var isLoading = true;
  String? error;

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : groceryList.isEmpty
                  ? const Center(
                      child:
                          Text('You got no grocery item, start adding some!'),
                    )
                  : ListView.builder(
                      itemCount: groceryList.length,
                      itemBuilder: (context, index) {
                        final groceryItem = groceryList[index];
                        return GroceryListTile(
                          groceryItem: groceryItem,
                          onDismissed: () => _removeItem(groceryItem),
                        );
                      },
                    ),
    );
  }

  Future<void> _loadItems() async {
    final url = Uri.https(baseUrl, shoppingListPath);

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        isLoading = false;
        error = 'Failed to fetch data, please try again later.';
      });
      return;
    }

    if (response.body == 'null') {
      setState(() => isLoading = false);
      return;
    }

    Map<String, dynamic> listData = json.decode(response.body);
    List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      item.value['id'] = item.key;
      loadedItems.add(GroceryItem.fromMap(item.value));
    }

    setState(() {
      groceryList = loadedItems;
      isLoading = false;
    });
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
