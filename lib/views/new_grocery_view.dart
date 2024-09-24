import 'package:flutter/material.dart';

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
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Form'),
      ),
    );
  }
}
