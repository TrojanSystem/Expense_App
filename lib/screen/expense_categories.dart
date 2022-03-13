import 'package:example/item/expense_categories_item.dart';
import 'package:flutter/material.dart';


class ExpenseCategories extends StatelessWidget {
  const ExpenseCategories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
        ),
        title: const Text('Expense Categories'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ExpenseCategoriesItem();
        },
      ),
    );
  }
}
