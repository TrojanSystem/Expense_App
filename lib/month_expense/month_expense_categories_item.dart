import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../model/monthly_budget_data.dart';
import '../model/transaction_data.dart';

class MonthExpenseCategoriesItem extends StatelessWidget {
  final List listOfExpense;
  final TransactionModel expense;
  final double totalPrice;
  final int index;

  MonthExpenseCategoriesItem(
      {this.listOfExpense, this.index, this.expense, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final budget = Provider.of<MonthlyBudgetData>(context, listen: false)
        .monthlyBudgetList;
    budget.isEmpty
        ? Provider.of<TransactionData>(context, listen: false).monthlyBudget = 0
        : Provider.of<TransactionData>(context, listen: false).monthlyBudget =
            double.parse(budget.first.budget);
    var y = listOfExpense.map((e) => e.name).toSet().toList();
    var x = listOfExpense.where((e) => e.name.toString() == y[index]).toList();
    var z = x.map((e) => e.name).toList();
    var zz = x.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }
    double xxx = ((sum * 100) / double.parse(budget.first.budget));

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
                        currentValue: double.parse(budget.first.budget) == 0
                            ? (0).floor()
                            : xxx.floor(),
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
              onPressed: () {},
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
