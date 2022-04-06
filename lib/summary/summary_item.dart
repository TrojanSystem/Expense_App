import 'package:example/summary/summary_expense_list.dart';
import 'package:example/summary/summary_income_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/transaction_data.dart';

class SummaryItem extends StatefulWidget {
  final int index;
  final int currentYear;

  SummaryItem({this.index, this.currentYear});

  @override
  State<SummaryItem> createState() => _SummaryItemState();
}

class _SummaryItemState extends State<SummaryItem> {
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final summaryDataList = Provider.of<TransactionData>(context).expenseList;
    final monthOfYear = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    final filtereByYear = summaryDataList
        .where((element) =>
            DateTime.parse(element.date).year == widget.currentYear)
        .toList();
    var monthSummaryExpenseList =
        filtereByYear.where((element) => element.isIncome == false).toList();

    var monthExpense = monthSummaryExpenseList
        .where((element) =>
            DateFormat.MMM().format(DateTime.parse(element.date)).toString() ==
            monthOfYear[widget.index])
        .toList();
    var monthExpenseSummary = monthExpense.map((e) => e.price).toList();
    var sumExpense = 0.0;
    for (int x = 0; x < monthExpenseSummary.length; x++) {
      sumExpense += double.parse(monthExpenseSummary[x]);
    }

    var monthSummaryIncomeList =
        filtereByYear.where((element) => element.isIncome == true).toList();

    var monthIncome = monthSummaryIncomeList
        .where((element) =>
            DateFormat.MMM().format(DateTime.parse(element.date)).toString() ==
            monthOfYear[widget.index])
        .toList();
    var monthIncomeSummary = monthIncome.map((e) => e.price).toList();
    var sumIncome = 0.0;
    for (int x = 0; x < monthIncomeSummary.length; x++) {
      sumIncome += double.parse(monthIncomeSummary[x]);
    }
    double totalSummaryDetail(double sumIncome, double sumExpense) {
      totalSumation = sumIncome - sumExpense;
      if (totalSumation < 0) {
        totalSumation = totalSumation * (-1);
        isNegative = true;
        return totalSumation;
      } else {
        isNegative = false;
        return totalSumation;
      }
    }

    return InkWell(
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              margin: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(40, 53, 147, 1),
                    const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(4, 8), // changes position of shadow
                  ),
                ],
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isTapped
                  ? isExpanded
                      ? 120
                      : 125
                  : isExpanded
                      ? 195
                      : 200,
              width: isExpanded ? 345 : 350,
              child: isTapped
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 25, bottom: 25, left: 5),
                            child: Center(
                              child: Text(
                                monthOfYear[widget.index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.blue,
                            //     width: 2,
                            //   ),
                            // ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Income',
                                        style: kkSummaryIncome,
                                      ),
                                      Text(
                                        sumIncome.toStringAsFixed(2),
                                        style: kkSummaryIncome,
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Expense',
                                        style: kkSummaryExpense,
                                      ),
                                      Text(sumExpense.toStringAsFixed(2),
                                          style: kkSummaryExpense),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        totalSummaryDetail(
                                                sumIncome, sumExpense)
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                          color: isNegative
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          isTapped
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Colors.black,
                          size: 27,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 20, left: 5),
                                child: Center(
                                  child: Text(
                                    monthOfYear[widget.index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     color: Colors.blue,
                                //     width: 2,
                                //   ),
                                // ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Income',
                                            style: kkSummaryIncome,
                                          ),
                                          Text(
                                            sumIncome.toStringAsFixed(2),
                                            style: kkSummaryIncome,
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Expense',
                                            style: kkSummaryExpense,
                                          ),
                                          Text(sumExpense.toStringAsFixed(2),
                                              style: kkSummaryExpense),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            totalSummaryDetail(
                                                    sumIncome, sumExpense)
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                              color: isNegative
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              isTapped
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: Colors.black,
                              size: 27,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => SummaryIncomeList(
                                            month: monthOfYear[widget.index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Income Detail',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => SummaryExpenseList(
                                              month: monthOfYear[widget.index]),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Expense Detail',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //   SummaryExpenseList(index: widget.index,listMonth: monthOfYear,)
                            ],
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
