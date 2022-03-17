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
    final result = Provider.of<TransactionData>(context).expenseList;
    var zz = result
        .where(
            (element) => DateTime.parse(element.date).day == widget.selectedDayExpenses)
        .toList();

    var totalExpenses = result.map((e) => e.price).toList();
    var totSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totSum += double.parse(totalExpenses[xx]);
    }
    var z = zz.map((e) => e.price).toList();
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
              const Income(),
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
