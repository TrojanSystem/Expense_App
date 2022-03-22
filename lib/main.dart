import 'package:example/screen/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'annually_expense/switcher.dart';
import 'model/monthly_budget_data.dart';
import 'model/transaction_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TransactionData()..loadExpenseList(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => MonthlyBudgetData()..loadMonthlyBudgetList(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
