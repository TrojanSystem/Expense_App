import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/monthly_budget_data.dart';
import '../model/transaction_data.dart';

class ExpenseCategoryItems extends StatefulWidget {
  final int index;
  final TransactionModel expense;

  ExpenseCategoryItems({
    this.expense,
    this.index,
  });

  @override
  State<ExpenseCategoryItems> createState() => _ExpenseCategoryItemsState();
}

class _ExpenseCategoryItemsState extends State<ExpenseCategoryItems> {
  bool isTapped = true;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<TransactionData>(context).expenseList;
    var totExpe = result.where((element) => element.isIncome == false).toList();
    var monthExpenseFilter = totExpe
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    var totalExpenses = monthExpenseFilter.map((e) => e.price).toList();
    var totSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totSum += double.parse(totalExpenses[xx]);
    }

    var y = monthExpenseFilter.map((e) => e.name).toSet().toList();

    var x = monthExpenseFilter
        .where((e) => e.name.toString() == y[widget.index])
        .toList();
    var z = x.map((e) => e.name).toList();
    var zz = x.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(zz[x]);
    }

    var detailMonthFilter = result
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    final detail = detailMonthFilter
        .where((element) => element.name.toString() == y[widget.index])
        .toList();

    return SizedBox(
      width: double.infinity,
      //color: Colors.blue,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        onHighlightChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isTapped
                  ? isExpanded
                      ? 80
                      : 85
                  : isExpanded
                      ? 245
                      : 250,
              width: isExpanded ? 345 : 350,
              child: isTapped
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      y[widget.index],
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
                                ],
                              ),
                              Icon(
                                isTapped
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.black,
                                size: 27,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      y[widget.index],
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
                                ],
                              ),
                              Icon(
                                isTapped
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.black,
                                size: 27,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: detail.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(detail[index].description),
                                subtitle: Text(
                                  DateFormat.yMMMEd().format(
                                    DateTime.parse(detail[index].date),
                                  ),
                                ),
                                trailing: Text(detail[index].price),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
