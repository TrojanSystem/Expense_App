import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../model/monthly_budget_data.dart';
import '../model/transaction_data.dart';

class MonthExpenseCategoriesItem extends StatelessWidget {
  final List todayFilteredList;
  final TransactionModel expense;
  final int selectedMonth;
  final int index;

  const MonthExpenseCategoriesItem(
      {Key key,
      this.todayFilteredList,
      this.index,
      this.expense,
      this.selectedMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthBudgetInYear =
        Provider.of<MonthlyBudgetData>(context).monthlyBudgetList;
    final dateFilter = monthBudgetInYear
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();
    final budget = dateFilter
        .where(
            (element) => (DateTime.parse(element.date)).month == selectedMonth)
        .toList();
    budget.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    budget.isEmpty
        ? Provider.of<TransactionData>(context).monthlyBudget = 0
        : Provider.of<TransactionData>(context).monthlyBudget =
            double.parse(budget.last.budget);
    final monthData = Provider.of<TransactionData>(context).monthlyBudget;
    var y = todayFilteredList.map((e) => e.name).toSet().toList();
    y.sort();
    var x =
        todayFilteredList.where((e) => e.name.toString() == y[index]).toList();
    var z = x.map((e) => e.name).toList();
    var zz = x.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }
    double xxx = ((sum * 100) / monthData);

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
                      progressColor: monthData == 0
                          ? Colors.green
                          : xxx.floor() < 75
                              ? Colors.green
                              : xxx.floor() < 100
                                  ? Colors.redAccent
                                  : Colors.red[800],
                      currentValue: monthData == 0 ? (0).floor() : xxx.floor(),
                      displayText: '%',
                      displayTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: IconButton(
              onPressed: () {
                Provider.of<TransactionData>(context, listen: false)
                    .deleteExpenseList(expense.id);
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
