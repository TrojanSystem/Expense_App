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
    final monthSelected = Provider.of<TransactionData>(context).monthOfAYear;
    final yearFilter = Provider.of<TransactionData>(context).expenseList;
    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();
    var totExpe = result.where((element) => element.isIncome == false).toList();
    var monthExpenseFilter = totExpe
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();
    var y = monthExpenseFilter.map((e) => e.name).toSet().toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(40, 53, 147, 1),
              Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9),
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
        ),
        title: const Text('Expense Tracker'),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonth,
            items: monthSelected
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(
                      e['mon'],
                      style: kkDropDown,
                    ),
                    value: e['day'],
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
          ),
        ],
      ),
      body: Consumer<TransactionData>(
        builder: (context, file, child) {
          return ListView.builder(
            itemCount: y.length,
            itemBuilder: (context, index) {
              return ExpenseCategoryItems(
                monthExpenseList: monthExpenseFilter,
                expense: result[index],
                index: index,
                selectedMonth: selectedMonth,
              );
            },
          );
        },
      ),
    );
  }
}
