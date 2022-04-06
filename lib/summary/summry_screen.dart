import 'package:example/model/transaction_data.dart';
import 'package:example/summary/summary_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final summaryData = Provider.of<TransactionData>(context).expenseList;

    final filtereByYear = summaryData
        .where((element) => DateTime.parse(element.date).year == currentYear)
        .toList();

    var isIncome =
        filtereByYear.where((element) => element.isIncome == true).toList();

    var incomeFiltereByMonth =
        isIncome.map((e) => DateTime.parse(e.date).month).toSet().toList();

    var totalIncome = isIncome.map((e) => e.price).toList();
    var totIncomeSum = 0.0;
    for (int xx = 0; xx < totalIncome.length; xx++) {
      totIncomeSum += double.parse(totalIncome[xx]);
    }
    var isExpense =
        filtereByYear.where((element) => element.isIncome == false).toList();
    var totalExpenses = isExpense.map((e) => e.price).toList();
    var totExpenseSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totExpenseSum += double.parse(totalExpenses[xx]);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentYear -= 1;
                            print(currentYear);
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          currentYear.toString(),
                          style: kkSummaryStyle,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentYear = currentYear + 1;
                            print(currentYear);
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Income',
                          style: kkSummaryIncomeStyle,
                        ),
                        Text(
                          totIncomeSum.toStringAsFixed(2),
                          style: kkSummaryIncomeStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 18),
                    child: Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Expense',
                          style: kkSummaryIncomeStyle,
                        ),
                        Text(
                          totExpenseSum.toStringAsFixed(2),
                          style: kkSummaryIncomeStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return SummaryItem(
                  currentYear: currentYear,
                  index: index,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
