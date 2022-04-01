import 'package:example/item/expense_categories_item.dart';
import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'month_expense_categories_item.dart';

class MonthExpenseCategories extends StatefulWidget {
  const MonthExpenseCategories({Key key}) : super(key: key);

  @override
  State<MonthExpenseCategories> createState() => _MonthExpenseCategoriesState();
}

class _MonthExpenseCategoriesState extends State<MonthExpenseCategories> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final monthSelected = Provider.of<TransactionData>(context).monthOfAYear;
    final monthFilterList = Provider.of<TransactionData>(context).expenseList;
    var todayFilteredExpenseList = monthFilterList
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();
    var todayFilteredList = todayFilteredExpenseList
        .where((element) => element.isIncome == false)
        .toList();
    var y = todayFilteredList.map((e) => e.name).toSet().toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
                colors: [    Color.fromRGBO(40, 53, 147, 1),
                  Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
        ),
        title: const Text('Monthly Expense'),
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
          final totPrice = Provider.of<TransactionData>(context).totalPrice;

          return ListView.builder(
            itemCount: y.length,
            itemBuilder: (context, index) {
              return MonthExpenseCategoriesItem(
                selectedMonthOfYear: selectedMonth,
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
