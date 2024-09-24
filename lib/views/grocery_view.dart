import 'package:flutter/material.dart';

import '../data/dummy_items.dart';
import '../widgets/grocery_list_tile.dart';
import 'new_grocery_view.dart';

class GroceryView extends StatelessWidget {
  const GroceryView({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewGroceryView(),
              ),
            ),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) =>
            GroceryListTile(groceryItem: groceryItems[index]),
      ),
    );
  }
}
