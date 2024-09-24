import 'package:flutter/material.dart';

import '../data/categories.dart';

class NewGroceryView extends StatefulWidget {
  const NewGroceryView({super.key});

  @override
  State<NewGroceryView> createState() => _NewGroceryViewState();
}

class _NewGroceryViewState extends State<NewGroceryView> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new grocery item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '1',
                      decoration: const InputDecoration(labelText: 'Quantity'),
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
                    onPressed: () {},
                    child: const Text('Rest'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
}
