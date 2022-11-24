import 'package:example/input_form/transaction_update_form_item.dart';
import 'package:example/model/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class IncomeDetail extends StatefulWidget {
  IncomeDetail({Key key}) : super(key: key);

  @override
  State<IncomeDetail> createState() => _IncomeDetailState();
}

class _IncomeDetailState extends State<IncomeDetail> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelected = Provider.of<TransactionData>(context).monthOfAYear;
    final daysFilterListInYear =
        Provider.of<TransactionData>(context).expenseList;
    final daysFilterList = daysFilterListInYear
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();
    var todayMonthFilteredList = daysFilterList
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();

    var incomeDetail = todayMonthFilteredList
        .where((element) => element.isIncome == true)
        .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //  centerTitle: true,
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Income Detail',
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
      body: incomeDetail.isNotEmpty
          ? AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: incomeDetail.length,
                itemBuilder: (BuildContext context, int index) {
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
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                    child: const Text('No'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Provider.of<TransactionData>(context,
                                              listen: false)
                                          .deleteExpenseList(
                                              incomeDetail[index].id);
                                      Navigator.of(ctx).pop(true);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                                content: const Text(
                                    'Do you want to remove this income?'),
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
                                builder: (ctx) => TransactionUpdateForm(
                                    isExpense: incomeDetail[index].isIncome,
                                    index: incomeDetail[index].id,
                                    existedIsIncome:
                                        incomeDetail[index].isIncome,
                                    existedDescription:
                                        incomeDetail[index].description,
                                    existedName: incomeDetail[index].name,
                                    existedPrice: incomeDetail[index].price,
                                    existedDate: incomeDetail[index].date));
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
                                        incomeDetail[index].price.toString(),
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
                                  child: ListTile(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        incomeDetail[index].name,
                                        style: storageItemName,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          incomeDetail[index].description,
                                          style: storageItemDate,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat.yMMMEd().format(
                                            DateTime.parse(
                                                incomeDetail[index].date),
                                          ),
                                          style: storageItemDate,
                                        ),
                                      ],
                                    ),
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
                          height: _w / 4,
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
                'Not Yet!',
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
