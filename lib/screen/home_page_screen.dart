import 'package:example/item/account_item.dart';
import 'package:example/item/drawer_item.dart';
import 'package:example/input_form/monthly_form_item.dart';
import 'package:example/item/transaction_tile_income.dart';
import 'package:example/model/monthly_budget_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../input_form/transaction_form_item.dart';
import '../item/transaction_tile_expense.dart';
import '../model/transaction_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedDayOfMonth = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    final daysInAMonth = Provider.of<TransactionData>(context).daysOfMonth;
    final daysFilterList = Provider.of<TransactionData>(context).expenseList;
    var todayFilteredList = daysFilterList
        .where(
            (element) => DateTime.parse(element.date).day == selectedDayOfMonth)
        .toList();
    final result = Provider.of<TransactionData>(context).expenseList;
    var z = result.map((e) => e.price).toList();
    var sum = 0.0;
    for (int x = 0; x < z.length; x++) {
      sum += double.parse(z[x]);
    }
    final monthData =
        Provider.of<TransactionData>(context).monthTotalPrice = sum;

    final budget = Provider.of<MonthlyBudgetData>(context).monthlyBudgetList;
    final dateFilter = budget.where((element) =>
        DateTime.parse(element.date).month == DateTime.now().month);

    dateFilter.isEmpty
        ? Provider.of<TransactionData>(context).monthlyBudget = 0
        : Provider.of<TransactionData>(context).monthlyBudget =
            double.parse(dateFilter.last.budget);
    final percentage = Provider.of<TransactionData>(context).percent();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction',
          style: TextStyle(
            letterSpacing: 1.1,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
        elevation: 0,
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedDayOfMonth,
            items: daysInAMonth
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
                selectedDayOfMonth = value;
              });
            },
          ),
        ],
      ),
      drawer: DrawerItem(selectedDayExpenses: selectedDayOfMonth),
      body: ListView(
        children: [
          SizedBox(
            height: 650,
            width: double.infinity,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color.fromRGBO(40, 53, 147, 1),
                    child: Account(selectedDayExpenses: selectedDayOfMonth),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Consumer<TransactionData>(
                    builder: (context, data, child) => data.expenseList.isEmpty
                        ? const Center(
                            child: Text(
                              'Enter Today\'s Transaction',
                              style: kkStyles,
                            ),
                          )
                        : ListView.builder(
                            itemCount: todayFilteredList.length,
                            itemBuilder: (context, index) {
                              return data.isIncome
                                  ? TransactionTileIncome(
                                      index: index,
                                      expense: todayFilteredList[index],
                                      listOfExpenses: data.expenseList,
                                    )
                                  : TransactionTileExpense(
                                      index: index,
                                      expense: todayFilteredList[index],
                                    );
                            },
                          ),
                    // : ListView.builder(
                    //     itemCount: data.expenseList.length,
                    //     itemBuilder: (context, index) {
                    //       return TransactionTileExpense(
                    //         index: index,
                    //         expense: data.expenseList[index],
                    //
                    //       );
                    //     },
                    //   ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(40, 53, 147, 1),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 20,
                width: 200,
                child: FAProgressBar(
                  size: 20,
                  backgroundColor: Colors.grey,
                  progressColor: percentage < 75
                      ? Colors.green
                      : percentage < 100
                          ? Colors.redAccent
                          : Colors.red[800],
                  currentValue: percentage,
                  displayText: '%',
                  displayTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: (ctx) => const MonthlyForm());
                  setState(() {});
                },
                child: dateFilter.isEmpty
                    ? const Text(
                        'Budget',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        '${dateFilter.last.budget} ETB',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
              const SizedBox(
                width: 60,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (ctx) => const TransactionForm());
        },
      ),
    );
  }
}
