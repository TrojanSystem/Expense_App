import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense.dart';
import 'income.dart';

class Account extends StatefulWidget {
  int selectedDayExpenses = 1;

  Account({this.selectedDayExpenses});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final yearFilter = Provider.of<TransactionData>(context).expenseList;
    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();

    var todayMonthFilteredList = result
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    var zz = todayMonthFilteredList
        .where((element) =>
            DateTime.parse(element.date).day == widget.selectedDayExpenses)
        .toList();
    var zzz = zz.where((element) => element.isIncome == false).toList();
    var isIncome = result.where((element) => element.isIncome == true).toList();
    var totInc = isIncome
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    var totalIncome = totInc.map((e) => e.price).toList();
    var totIncomeSum = 0.0;
    for (int xx = 0; xx < totalIncome.length; xx++) {
      totIncomeSum += double.parse(totalIncome[xx]);
    }
    var monthExpenseFilter =
        result.where((element) => element.isIncome == false).toList();
    var totExpe = monthExpenseFilter
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();

    var totalExpenses = totExpe.map((e) => e.price).toList();
    var totSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totSum += double.parse(totalExpenses[xx]);
    }
    var z = zzz.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(z[x]);
    }

    return Consumer<TransactionData>(
      builder: (context, data, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Income(dailyIncome: totIncomeSum.toStringAsFixed(2)),
              Container(width: 2, height: 100, color: Colors.white54),
              Expense(dailyExpense: totSum.toStringAsFixed(2)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Daily Expense: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                sum.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
