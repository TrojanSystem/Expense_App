import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/transaction_model.dart';

class DatabaseExpense {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'expenseList.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE expenseList(id INTEGER PRIMARY KEY, name TEXT, price TEXT, date TEXT, total TEXT, description TEXT)''',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(TransactionModel task) async {
    Database db = await database();
    int data = await db.insert('expenseList', task.toMap());
    return data;
  }

  Future<List<TransactionModel>> getTasks() async {
    Database db = await database();
    var tasks = await db.query('expenseList');
    List<TransactionModel> tasksList = tasks.isNotEmpty
        ? tasks.map((e) => TransactionModel.fromMap(e)).toList()
        : [];
    return tasksList;
  }

  Future<bool> updateTaskList(TransactionModel item) async {
    final Database db = await database();
    final rows = await db.update(
      'expenseList',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rows > 0;
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM expenseList WHERE id = '$id'");
  }
}
