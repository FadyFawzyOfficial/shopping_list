import 'package:flutter/material.dart';

import '../models/grocery_item.dart';

class GroceryListTile extends StatelessWidget {
  final GroceryItem groceryItem;

  const GroceryListTile({super.key, required this.groceryItem});

  @override
  Widget build(context) {
    return ListTile(
      leading: Icon(
        Icons.square_rounded,
        color: groceryItem.category.color,
      ),
      title: Text(groceryItem.name),
      trailing: Text('${groceryItem.quantity}'),
    );
  }
}
