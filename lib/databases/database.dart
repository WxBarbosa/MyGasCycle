import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/gas.model.dart';

class DBProvider{
  final Future<Database> database = openDatabase(
    // Set the path to the database.
    join(getDatabasesPath().toString(), 'gas_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate:(db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE gas(id INTEGER PRIMARY KEY, kilograms INTEGER, buyDate TEXT, createdAt TEXT)"
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertGas(Gas gas) async{
    print(gas);
    final Database db = await this.database;
    final String table = "gas";

    await db.insert(
      table,
      gas.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Gas>> getAllGas() async {
    final Database db = await this.database;
    final String table = "gas"; 

    final List<Map<String, dynamic>> maps = await db.query(table, orderBy: 'buyDate');

    return List.generate(maps.length, (i) {
      return Gas(
        id: maps[i]['id'],
        kilograms: maps[i]['kilograms'],
        buyDate: maps[i]['buyDate']
      );
    });
  }
}