import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../model/monthly_budget_data.dart';
import '../model/transaction_data.dart';

class ExpenseCategoryItems extends StatelessWidget {
  final int index;
  final TransactionModel expense;

  ExpenseCategoryItems({
    this.expense,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<TransactionData>(context).expenseList;
    var totExpe = result.where((element) => element.isIncome == false).toList();

    var totalExpenses = totExpe.map((e) => e.price).toList();
    var totSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totSum += double.parse(totalExpenses[xx]);
    }

    var y = totExpe.map((e) => e.name).toSet().toList();

    var x = totExpe.where((e) => e.name.toString() == y[index]).toList();
    var z = x.map((e) => e.name).toList();
    var zz = x.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }

    return SizedBox(
      width: double.infinity,
      //color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 18.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      y[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      height: 25,
                      width: 250,
                      child: FAProgressBar(
                        backgroundColor: Colors.black12,
                        size: 20,
                        progressColor: Colors.green,
                        currentValue: totSum == 0
                            ? (0).floor()
                            : ((sum * 100) / totSum).floor(),
                        displayText: '%',
                        displayTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {
                Provider.of<TransactionData>(context,listen: false).deleteExpenseList(expense.id);
              },
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
