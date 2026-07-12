import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medicine_reminder/models/medicine.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    final databasePath = getDatabasesPath();
    final path = join(await databasePath, 'medicine_reminder.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE medicines(
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

  Future<int> insertMedicine(Medicine medicine) async{
    final db= await initDatabase();

    final id= await db.insert(
      'medicines',
      {
        'name': medicine.name,
        'personName': medicine.personName,
        'dosage': medicine.dosage,
        'reminderTime': medicine.reminderTime,
        'createdAt': medicine.createdAt,
      },
    );
    return id;
  }

  Future<int> updateMedicine(Medicine medicine) async{
    final db=await initDatabase();

    return await db.update(
        'medicines',
        {
          'name': medicine.name,
          'personName': medicine.personName,
          'dosage': medicine.dosage,
          'reminderTime': medicine.reminderTime,
          'createdAt': medicine.createdAt,
        },
        where: 'id=?',
        whereArgs:[medicine.id]
    );
  }

  Future<int> deleteMedicine(int id) async{
    final db=await initDatabase();
    return await db.delete(
      'medicines',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<List<Medicine>> getMedicine() async{
    final db= await initDatabase();
    final data= await db.query('medicines');
    List<Medicine> medicines=[];
    for(int i=0; i<data.length; i++){
      var item=data[i];
      Medicine medicine=Medicine(
        id: item['id'] as int,
        name: item['name'] as String,
        personName: item['personName'] as String,
        dosage: item['dosage'] as String,
        reminderTime: item['reminderTime'] as String,
        createdAt: item['createdAt'] as String,
      );
      medicines.add(medicine);
    }
    return medicines;
  }
}