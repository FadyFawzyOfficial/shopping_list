import 'package:flutter/material.dart';

import '../models/grocery_item.dart';

class GroceryListTile extends StatelessWidget {
  final GroceryItem groceryItem;
  final VoidCallback onDismissed;

  const GroceryListTile({
    super.key,
    required this.groceryItem,
    required this.onDismissed,
  });

  @override
  Widget build(context) {
    return Dismissible(
      onDismissed: (direction) => onDismissed(),
      key: ValueKey(groceryItem.id),
      child: ListTile(
        leading: Icon(
          Icons.square_rounded,
          color: groceryItem.category.color,
        ),
        title: Text(groceryItem.name),
        trailing: Text('${groceryItem.quantity}'),
      ),
    );
  }
}
