import 'package:sqflite/sqflite.dart';

import '../model/transaction.dart';

class TransactionsDao {
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/transactions222.db';
    //await deleteDatabase(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Transactions (id TEXT PRIMARY KEY, title TEXT, emoji TEXT, amount NUMBER, timestamp TEXT, store TEXT)');
    });
  }

  addNew(TransactionExp transaction) async {
    await _database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Transactions (id, title, emoji, amount, timestamp, store) VALUES ("${transaction.id}","${transaction.title}", "${transaction.emoji}", ${transaction.amount}, "${transaction.timestamp.toIso8601String()}","${transaction.store}")');
    });
  }

  Future<List<TransactionExp>> getAll() async {
    await database;
    List<Map> list = await _database
        .rawQuery('SELECT * FROM Transactions ORDER BY timestamp DESC');

    return list.map((item) {
      return TransactionExp(
          amount: item['amount'].toDouble(),
          emoji: item['emoji'],
          id: item['id'],
          store: item['store'],
          timestamp: DateTime.parse(item['timestamp']),
          title: item['title']);
    }).toList();
  }
}
