import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import '../database/expense_database.dart';

class TransactionData extends ChangeNotifier {
  DatabaseExpense db = DatabaseExpense();
  double totalPrice = 0;
  double monthlyBudget = 0;
  bool isIncome = false;
  bool _isLoading = true;

  List<TransactionModel> _expenseList = [];

  List<TransactionModel> get expenseList => _expenseList;

  bool get isLoading => _isLoading;

  void updaterChanger() {
    isIncome = !isIncome;
    //notifyListeners();
  }

  Future loadExpenseList() async {
    _isLoading = true;
    notifyListeners();
    _expenseList = await db.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future addExpenseList(TransactionModel task) async {
    await db.insertTask(task);
    await loadExpenseList();
    notifyListeners();
  }

  Future updateExpenseList(TransactionModel task) async {
    await db.updateTaskList(task);
    await loadExpenseList();
    notifyListeners();
  }

  Future deleteExpenseList(int task) async {
    await db.deleteTask(task);
    await loadExpenseList();
    notifyListeners();
  }

  double addTotalPrice(price) {
    totalPrice += price;
    return totalPrice;
  }

  double update() {
    totalPrice;
    return totalPrice;
  }

  double minusTotalPrice(double price) {
    totalPrice = totalPrice - price;
    return totalPrice;
  }

  double updateTotalPrice(double price, double updatePrice) {
    totalPrice -= price;
    totalPrice += updatePrice;
    return totalPrice;
  }

// Future changeStatusForTask(TransactionModel task) async {
//   task.isCompeleted = !task.isCompeleted;
//
//   await db.updateTaskList(task);
//   _taskList = await db.getTasks();
//   notifyListeners();
// }

  int percent() {
    if (monthlyBudget == 0) {
      double percentage = 0;
      return percentage.floor();
    } else {
      double percentage = ((totalPrice * 100) / monthlyBudget);
      return percentage.floor();
    }
  }
}
