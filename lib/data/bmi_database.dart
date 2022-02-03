import 'dart:developer';

import 'package:bmicalculator/data/bmi_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class BMIDatabase{

  static final BMIDatabase instance = BMIDatabase._init();

  static Database? _database;

  BMIDatabase._init();

  Future<Database> get getDatabase async{
    if(_database != null) return _database!;

    _database = await _initDB('bmicalc.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async{
    final dbLocation = await getDatabasesPath();

    final path = p.join(dbLocation, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{

    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE $tableName ( 
  $field_id $idType, 
  $field_age $doubleType,
  $field_height $doubleType,
  $field_weight $doubleType,
  $field_bmi $doubleType,
  $field_dateTime $textType
  )
''');
  }

  Future<BMIModel> create(BMIModel bmiModel) async{
    final _db = await instance.getDatabase;

    int id = await _db.insert(tableName, bmiModel.toJson());

    log("from db.....id: ${id.toString()}");

    log("BMI table: ${bmiModel.toJson().toString()}");

    return bmiModel.generate(id: id);
  }

  Future<BMIModel> readData(int id) async{
    final _db = await instance.getDatabase;

    final data = await _db.query(
      tableName,
      columns: columns,
      where: '$field_id = ?',
      whereArgs: [id]
    );

    if(data.isNotEmpty){
      return BMIModel.fromJson(data.first);
    }else{
      throw Exception("$id not avail in database");
    }
  }

  Future<List<BMIModel>> readAll() async{
    final _db = await instance.getDatabase;

    final allData = await _db.query(tableName, orderBy: '$field_dateTime ASC');

    return allData.map((map) => BMIModel.fromJson(map)).toList();

  }

  Future<int> update(BMIModel bmiModel) async{
    final _db = await instance.getDatabase;

    return _db.update(
      tableName,
      bmiModel.toJson(),
      where: '$field_id = ?',
      whereArgs: [bmiModel.id]
    );
  }

  Future<int> delete(int id) async{
    final _db = await instance.getDatabase;

    return await _db.delete(
      tableName,
      where: '$field_id = ?',
      whereArgs: [id]
    );
  }

  Future close() async{
    final _db = await instance.getDatabase;

    _db.close();
  }


}