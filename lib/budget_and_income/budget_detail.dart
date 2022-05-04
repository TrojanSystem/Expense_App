import 'package:example/model/monthly_budget_data.dart';
import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../input_form/monthly_update_form.dart';

enum Plan { overBudget, underBudget, onBudget }

class BudgetDetail extends StatefulWidget {
  BudgetDetail({Key key}) : super(key: key);

  @override
  State<BudgetDetail> createState() => _BudgetDetailState();
}

class _BudgetDetailState extends State<BudgetDetail> {
  int selectedMonth = DateTime.now().month;
  var monthPlan;
  Color colorIndicator = Colors.blue[800];
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelected = Provider.of<TransactionData>(context).monthOfAYear;
    final daysFilterListInYear =
        Provider.of<MonthlyBudgetData>(context).monthlyBudgetList;
    final daysFilterList = daysFilterListInYear
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();

    var budgetDetail = daysFilterList
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();
    budgetDetail.sort((a, b) => a.date.compareTo(b.date));

    //////////

    //////
    final yearFilter = Provider.of<TransactionData>(context).expenseList;
    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();

    var isIncome = result.where((element) => element.isIncome == true).toList();
    var totInc = isIncome
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();
    var totalIncome = totInc.map((e) => e.price).toList();
    var totIncomeSum = 0.0;
    for (int xx = 0; xx < totalIncome.length; xx++) {
      totIncomeSum += double.parse(totalIncome[xx]);
    }
    var monthExpenseFilter =
        result.where((element) => element.isIncome == false).toList();
    var totExpe = monthExpenseFilter
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();

    var totalExpenses = totExpe.map((e) => e.price).toList();
    var totExpenseSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totExpenseSum += double.parse(totalExpenses[xx]);
    }
    final double total = totIncomeSum - totExpenseSum;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //  centerTitle: true,
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Budget Detail',
        ),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonth,
            items: monthSelected
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(
                      e['mon'],
                      style: kkDropDown,
                    ),
                    value: e['day'],
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
          ),
        ],
      ),
      body: budgetDetail.isNotEmpty
          ? AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  if (double.parse(budgetDetail.last.budget) > total) {
                    monthPlan = 'Under-Budget';
                    colorIndicator = Colors.green[800];
                  } else if (double.parse(budgetDetail.last.budget) < total) {
                    monthPlan = 'Over-Budget';
                    colorIndicator = Colors.red[800];
                  } else {
                    monthPlan = ' On-Budget';
                    colorIndicator = Colors.blue[800];
                  }
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Are you sure'),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: const Text('No'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Provider.of<TransactionData>(context,
                                              listen: false)
                                          .deleteExpenseList(
                                              budgetDetail.last.id);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                                content: const Text(
                                    'Do you want to remove this item from the cart?'),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          color: Colors.green,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (ctx) => MonthlyUpdateForm(
                                    index: budgetDetail.last.id,
                                    existedBudget: budgetDetail.last.budget,
                                    existedDate: budgetDetail.last.date));
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    child: AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: -300,
                        verticalOffset: -850,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        budgetDetail.last.budget.toString(),
                                        style: storageItemMoney,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'ETB',
                                        style: storageItemCurrency,
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Income',
                                              style: storageItemName,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0, right: 18.0),
                                              child: Text(
                                                totIncomeSum.toStringAsFixed(2),
                                                style: storageItemName,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 8.0, top: 0),
                                              child: Text(
                                                'Expense',
                                                style: storageItemName,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  right: 18,
                                                  top: 0),
                                              child: Text(
                                                totExpenseSum
                                                    .toStringAsFixed(2),
                                                style: storageItemName,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${String.fromCharCode(0x03A3)} =$total',
                                              style: storageItemName,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: Text(
                                                monthPlan.toString(),
                                                style: TextStyle(
                                                    color: colorIndicator,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: _w / 20),
                          height: _w / 3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
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
            )
          : const Center(
              child: Text(
                'No Plan for this month yet!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
    );
  }
}
