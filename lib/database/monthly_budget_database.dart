import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/month_budget_model.dart';

class DatabaseMonthlyExpense {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'budgetList.db'),
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE budgetList(id INTEGER PRIMARY KEY, budget TEXT)''');
      },
      version: 1,
    );
  }

  Future<int> insertTask(MonthlyBudget task) async {
    Database db = await database();
    int data = await db.insert('budgetList', task.toMap());
    return data;
  }

  Future<List<MonthlyBudget>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('budgetList');
    List<MonthlyBudget> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => MonthlyBudget.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(MonthlyBudget item) async {
    final Database db = await database();
    final rows = await db.update(
      'budgetList',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM budgetList WHERE id = '$id'");
  }
}
