import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../input_form/transaction_update_form_item.dart';
import '../model/transaction_data.dart';

class SummaryIncomeList extends StatelessWidget {
  // final int index;
  final String month;
  final int selectedCurrentYear;

  SummaryIncomeList({this.month, this.selectedCurrentYear});

  @override
  Widget build(BuildContext context) {
    final accessor = Provider.of<TransactionData>(context);
    final summaryDataList = Provider.of<TransactionData>(context).expenseList;
    final filtereByYear = summaryDataList
        .where((element) =>
            DateTime.parse(element.date).year == selectedCurrentYear)
        .toList();
    var monthSummaryExpenseList =
        filtereByYear.where((element) => element.isIncome == true).toList();

    var monthExpense = monthSummaryExpenseList
        .where((element) =>
            DateFormat.MMM().format(DateTime.parse(element.date)).toString() ==
            month.toString())
        .toList();
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor:
              const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9),
          title: const Text('Income Detail'),
          centerTitle: true,
          brightness: Brightness.dark),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: monthExpense.length,
          itemBuilder: (BuildContext context, int index) {
            monthExpense.sort((a, b) => b.date.compareTo(a.date));
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: -300,
                verticalOffset: -850,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => TransactionUpdateForm(
                          index: monthExpense[index].id,
                          existedIsIncome: monthExpense[index].isIncome,
                          existedDescription: monthExpense[index].description,
                          existedName: monthExpense[index].name,
                          existedPrice: monthExpense[index].price,
                          existedDate: monthExpense[index].date),
                    );
                  },
                  onLongPress: () {
                    accessor.deleteExpenseList(monthExpense[index].id);
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 15, 0),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    monthExpense[index].name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    monthExpense[index].description,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 120,
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.arrow_downward_rounded,
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
                    margin: EdgeInsets.only(bottom: _w / 20),
                    height: _w / 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
