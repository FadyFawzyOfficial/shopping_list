import 'dart:convert';

import 'category.dart';

class GroceryItem {
  final String? id;
  final String name;
  final int quantity;
  final Category category;

  const GroceryItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'name': name,
      'quantity': quantity,
      'category': category.name,
    };
  }

  factory GroceryItem.fromMap(Map<String, dynamic> map) {
    return GroceryItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      category: Category.fromName(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryItem.fromJson(String source) =>
      GroceryItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
