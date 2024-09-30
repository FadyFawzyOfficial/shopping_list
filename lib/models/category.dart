import 'package:flutter/material.dart';

import '../data/categories.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category {
  final String name;
  final Color color;

  const Category(
    this.name,
    this.color,
  );

  factory Category.fromName(String name) => categories.entries
      .firstWhere((category) => category.value.name == name)
      .value;
}
