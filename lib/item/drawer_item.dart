import 'package:example/screen/expense_categories.dart';
import 'package:example/summary/summry_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../expense_tracker/expense_categories.dart';
import '../month_expense/month_expense_categories.dart';

class DrawerItem extends StatelessWidget {
  final int selectedDayExpenses;

  DrawerItem({this.selectedDayExpenses});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Personal Expense',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromRGBO(40, 53, 147, 1),
                  const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9),
                ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Text(
                        'Daily Expense',
                        style: kkExpense,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ExpenseCategories(
                                passedIntExpense: selectedDayExpenses),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: const Text(
                        'Expense Tracker',
                        style: kkExpense,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const ExpenseCategory(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: const Text(
                        'Monthly Percentage',
                        style: kkExpense,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const MonthExpenseCategories(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: const Text(
                        'Yearly Analysis',
                        style: kkExpense,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const SummaryScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
