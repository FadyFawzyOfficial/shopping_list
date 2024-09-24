import 'package:flutter/material.dart';

import '../widgets/grocery_list_tile.dart';
import 'new_grocery_view.dart';

class GroceryView extends StatefulWidget {
  const GroceryView({super.key});

  @override
  State<GroceryView> createState() => _GroceryViewState();
}

class _GroceryViewState extends State<GroceryView> {
  final groceryList = [];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () async {
              final newGroceryItem = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewGroceryView()),
              );

              if (newGroceryItem != null) {
                setState(() {
                  groceryList.add(newGroceryItem);
                });
              }
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (context, index) =>
            GroceryListTile(groceryItem: groceryList[index]),
      ),
    );
  }
}
