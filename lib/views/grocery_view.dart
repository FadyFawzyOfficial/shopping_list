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

  Future<void> _addItem() async {
    final newGroceryItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewGroceryView()),
    );

    if (newGroceryItem != null) {
      setState(() => groceryList.add(newGroceryItem));
    }
  }
}
