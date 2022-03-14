import 'package:example/item/expense_categories_item.dart';
import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthExpenseCategories extends StatelessWidget {
  const MonthExpenseCategories({Key key}) : super(key: key);

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
        title: const Text('Monthly Expense Categories'),
      ),
      body: Consumer<TransactionData>(
        builder: (context, file, child) {
          final totPrice = Provider.of<TransactionData>(context).totalPrice;
          final filter = Provider.of<TransactionData>(context).expenseList;
          final length = filter.map((e) => e.name).toSet().toList();
          return ListView.builder(
            itemCount: length.length,
            itemBuilder: (context, index) {
              return ExpenseCategoriesItem(
                listOfExpense: file.expenseList,
                expense: file.expenseList[index],
                totalPrice: totPrice,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
