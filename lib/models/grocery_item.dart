import 'dart:convert';

import 'category.dart';

class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final Category category;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category.name,
    };
  }

  factory GroceryItem.fromMap(Map<String, dynamic> map) {
    return GroceryItem(
      id: map['id'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      category: Category.fromName(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroceryItem.fromJson(String source) =>
      GroceryItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
