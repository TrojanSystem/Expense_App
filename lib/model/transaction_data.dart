import 'package:example/model/transaction_model.dart';
import 'package:flutter/material.dart';
import '../database/expense_database.dart';

class TransactionData extends ChangeNotifier {
  DatabaseExpense db = DatabaseExpense();
  double totalPrice = 0;
  double monthTotalPrice = 0;
  double monthlyBudget = 0;
  bool isIncome = false;
  bool isExpense = true;
  bool _isLoading = true;

  List<TransactionModel> _expenseList = [];

  List<TransactionModel> get expenseList => _expenseList;

  bool get isLoading => _isLoading;

  void updaterChanger(bool state) {
    isIncome = state;
    isExpense = state;
    // notifyListeners();
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
      double percentage = ((monthTotalPrice * 100) / monthlyBudget);
      return percentage.floor();
    }
  }
  List daysOfMonth = [
    {
      'mon': 'Day 1',
      'day': 1,
    },
    {
      'mon': 'Day 2',
      'day':2 ,
    },
    {
      'mon': 'Day 3',
      'day': 3,
    },
    {
      'mon': 'Day 4',
      'day':4,
    },
    {
      'mon': 'Day 5',
      'day': 5,
    },
    {
      'mon': 'Day 6',
      'day': 6,
    },
    {
      'mon': 'Day 7',
      'day':7,
    },
    {
      'mon': 'Day 8',
      'day': 8,
    },
    {
      'mon': 'Day 9',
      'day':9,
    },
    {
      'mon': 'Day 10',
      'day': 10,
    },
    {
      'mon': 'Day 11',
      'day': 11,
    },
    {
      'mon': 'Day 12',
      'day': 12,
    },
    {
      'mon': 'Day 13',
      'day':13,
    },
    {
      'mon': 'Day 14',
      'day': 14,
    },
    {
      'mon': 'Day 15',
      'day':15,
    },
    {
      'mon': 'Day 16',
      'day': 16,
    },
    {
      'mon': 'Day 17',
      'day':17,
    },
    {
      'mon': 'Day 18',
      'day': 18,
    },
    {
      'mon': 'Day 19',
      'day': 19,
    },
    {
      'mon': 'Day 20',
      'day':20,
    },
    {
      'mon': 'Day 21',
      'day': 21,
    },
    {
      'mon': 'Day 22',
      'day': 22,
    },
    {
      'mon': 'Day 23',
      'day': 23,
    },
    {
      'mon': 'Day 24',
      'day':24,
    },
    {
      'mon': 'Day 25',
      'day': 25,
    },
    {
      'mon': 'Day 26',
      'day': 26,
    },
    {
      'mon': 'Day 27',
      'day':27,
    },
    {
      'mon': 'Day 28',
      'day':28,
    },
    {
      'mon': 'Day 29',
      'day':29,
    },
    {
      'mon': 'Day 30',
      'day':30,
    },

    {
      'mon': 'Day 31',
      'day': 31,
    },
  ];


}
