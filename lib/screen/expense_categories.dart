import 'package:example/item/expense_categories_item.dart';
import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseCategories extends StatelessWidget {
  final int passedIntExpense;
   ExpenseCategories({this.passedIntExpense});

  @override
  Widget build(BuildContext context) {
    final result =Provider.of<TransactionData>(context).expenseList;
    var newDateList = result
        .where((element) =>
    DateTime.parse(element.date).day == passedIntExpense)
        .toList();
    var y = newDateList.map((e) => e.name).toSet().toList();
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
        title: const Text('Daily Expense Tracker'),
      ),
      body: Consumer<TransactionData>(
        builder: (context, file, child) {
          final totPrice = Provider.of<TransactionData>(context).totalPrice;
          final filter = Provider.of<TransactionData>(context).expenseList;
          final length = filter.map((e) => e.name).toSet().toList();
          return ListView.builder(
            itemCount: y.length,
            itemBuilder: (context, indexs) {

              return ExpenseCategoriesItem(
                recievedIntExpenses:passedIntExpense,
                listOfExpense: file.expenseList,
                expense: file.expenseList[indexs],
                totalPrice : totPrice,
                index: indexs,
              );
            },
          );
        },
      ),
    );
  }
}
