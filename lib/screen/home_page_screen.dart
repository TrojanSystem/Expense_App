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
  @override
  Widget build(BuildContext context) {
    final budgetData = Provider.of<TransactionData>(context);
    final budget = Provider.of<MonthlyBudgetData>(context).monthlyBudgetList;
    budget.isEmpty
        ? Provider.of<TransactionData>(context).monthlyBudget = 0
        : Provider.of<TransactionData>(context).monthlyBudget =
            double.parse(budget.first.budget);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction',
          style: TextStyle(
            letterSpacing: 1.1,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
        elevation: 0,
      ),
      drawer: const DrawerItem(),
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
                    child: const Account(),
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
                        : data.isIncome
                            ? ListView.builder(
                                itemCount: data.expenseList.length,
                                itemBuilder: (context, index) {
                                  print(data.isIncome);
                                  return TransactionTileIncome(
                                    index: index,
                                    expense: data.expenseList[index],
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: data.expenseList.length,
                                itemBuilder: (context, index) {
                                  print(data.isIncome);
                                  return TransactionTileExpense(
                                    index: index,
                                    expense: data.expenseList[index],
                                    change: data.isIncome,
                                  );
                                },
                              ),
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
                  progressColor: budgetData.percent() < 75
                      ? Colors.green
                      : budgetData.percent() < 100
                          ? Colors.redAccent
                          : Colors.red[800],
                  currentValue: budgetData.percent(),
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
                child: budget.isEmpty
                    ? const Text(
                        'Budget',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        '${budget.first.budget} ETB',
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
