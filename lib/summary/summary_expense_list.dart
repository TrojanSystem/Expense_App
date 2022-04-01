import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/transaction_data.dart';

class SummaryExpenseList extends StatelessWidget {
  // final int index;
  final String month;

  SummaryExpenseList({this.month});

  @override
  Widget build(BuildContext context) {
    final summaryDataList = Provider.of<TransactionData>(context).expenseList;
    final filtereByYear = summaryDataList
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();
    var monthSummaryExpenseList =
        filtereByYear.where((element) => element.isIncome == false).toList();

    var monthExpense = monthSummaryExpenseList
        .where((element) =>
            DateFormat.MMM().format(DateTime.parse(element.date)).toString() ==
            month.toString())
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Expense Detail'),
      ),
      body: ListView.builder(
          itemCount: monthExpense.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 8.0, 8, 0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 4,
                          offset:
                              const Offset(4, 8), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 90,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  DateFormat.yMMMEd().format(
                                    DateTime.parse(monthExpense[index].date),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(
                              monthExpense[index].name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 120,
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.arrow_upward_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                          const Text(
                            'ETB ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            monthExpense[index].price.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
