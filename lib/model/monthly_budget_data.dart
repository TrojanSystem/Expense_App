import 'package:example/database/monthly_budget_database.dart';
import 'package:flutter/material.dart';
import 'month_budget_model.dart';

class MonthlyBudgetData extends ChangeNotifier {
  DatabaseMonthlyExpense db = DatabaseMonthlyExpense();
  int taskDone = 0;
  bool _isMonthlyBudgetLoading = true;
  final bool _isTaped = true;
  List<MonthlyBudget> _monthlyBudgetList = [];

  List<MonthlyBudget> get monthlyBudgetList => _monthlyBudgetList;

  bool get isMonthlyBudgetLoading => _isMonthlyBudgetLoading;

  bool get isTaped => _isTaped;

  Future loadMonthlyBudgetList() async {
    _isMonthlyBudgetLoading = true;
    notifyListeners();
    _monthlyBudgetList = await db.getTasks();
    _isMonthlyBudgetLoading = false;
    notifyListeners();
  }

  Future addMonthlyBudgetList(MonthlyBudget task) async {
    await db.insertTask(task);
    await loadMonthlyBudgetList();
    notifyListeners();
  }

  Future updateMonthlyBudgetList(MonthlyBudget task) async {
    await db.updateTaskList(task);
    await loadMonthlyBudgetList();
    notifyListeners();
  }

  Future deleteMonthlyBudgetList(int task) async {
    await db.deleteTask(task);
    await loadMonthlyBudgetList();
    notifyListeners();
  }

// Future changeStatusForTask(TransactionModel task) async {
//   task.isCompeleted = !task.isCompeleted;
//
//   await db.updateTaskList(task);
//   _taskList = await db.getTasks();
//   notifyListeners();
// }

}
