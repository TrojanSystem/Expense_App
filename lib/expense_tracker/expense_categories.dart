import 'package:example/item/expense_categories_item.dart';
import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'expense_categories_item.dart';

class ExpenseCategory extends StatefulWidget {
  const ExpenseCategory({Key key}) : super(key: key);

  @override
  State<ExpenseCategory> createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<TransactionData>(context).expenseList;
    var totExpe = result.where((element) => element.isIncome == false).toList();

    var y = totExpe.map((e) => e.name).toSet().toList();

    return Scaffold(
      backgroundColor: Colors.white,
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
        title: const Text('Expense Tracker'),
      ),
      body: Consumer<TransactionData>(
        builder: (context, file, child) {
          return ListView.builder(
            itemCount: y.length,
            itemBuilder: (context, index) {
              return ExpenseCategoryItems(
                expense: result[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
