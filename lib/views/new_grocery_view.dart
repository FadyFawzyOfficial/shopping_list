import 'package:flutter/material.dart';

import '../data/categories.dart';

class NewGroceryView extends StatefulWidget {
  const NewGroceryView({super.key});

  @override
  State<NewGroceryView> createState() => _NewGroceryViewState();
}

class _NewGroceryViewState extends State<NewGroceryView> {
  final _formKey = GlobalKey<FormState>();

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
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '1',
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
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category,
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
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _formKey.currentState!.reset,
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

  void _saveItem() {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
    }
  }
}
