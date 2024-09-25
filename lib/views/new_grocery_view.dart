import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../data/categories.dart';
import '../models/grocery_item.dart';

class NewGroceryView extends StatefulWidget {
  const NewGroceryView({super.key});

  @override
  State<NewGroceryView> createState() => _NewGroceryViewState();
}

class _NewGroceryViewState extends State<NewGroceryView> {
  final _formKey = GlobalKey<FormState>();

  var _name = '';
  var _quantity = 1;
  var _category = categories.entries.first.value;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new grocery item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  final valueTrimmedLength = value?.trim().length;
                  if (value == null ||
                      value.isEmpty ||
                      valueTrimmedLength! <= 1 ||
                      valueTrimmedLength > 50) {
                    return 'Name must be 2 to 50 characters';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '$_quantity',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      validator: (value) {
                        final parsedQuantity = int.tryParse(value ?? '');
                        if (value == null ||
                            value.isEmpty ||
                            parsedQuantity == null ||
                            parsedQuantity <= 0) {
                          return 'Must be a valid, positive number';
                        }
                        return null;
                      },
                      onSaved: (value) => _quantity = int.parse(value!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _category,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.square_rounded,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 8),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) => _category = value!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _formKey.currentState!.reset(),
                    child: const Text('Rest'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveItem() async {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();

      final groceryItem = GroceryItem(
        name: _name,
        quantity: _quantity,
        category: _category,
      );

      final url = Uri.https(baseUrl, shoppingListPath);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: groceryItem.toJson(),
      );

      final String groceryItemId = json.decode(response.body)['name'];

      Navigator.pop(
        context,
        groceryItem.copyWith(id: groceryItemId),
      );
    }
  }
}
