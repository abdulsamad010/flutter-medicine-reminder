import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async {
  final databasePath = getDatabasesPath();
  final path = join(await databasePath, 'medicine_reminder.db');
  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE medicine(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
           name TEXT NOT NULL,
            personName TEXT NOT NULL,
            dosage TEXT NOT NULL,
            reminderTime TEXT NOT NULL,
            createdAt TEXT NOT NULL
          )
          ''');
    },
  );
  return database;
}
