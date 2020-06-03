import 'dart:io';

import 'package:mycontacts/Models/ContactModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  String contactTable = 'contact_table';
  String colId = 'id';
  String colFirstName = 'first_name';
  String colLastName = 'last_name';
  String colBirthDate = 'date_of_birth';
  String colPhoneNo = 'phone_no';
  String colEmail = 'email';
  String colGender = 'gender';
  static DatabaseHelper _databaseHelper; // SingleTon
  static Database _database;
  DatabaseHelper._createInstance(); //Named Constructor to create instance of DB Helper
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
    //db getter
  Future<Database> get database async {
    if(_database==null){
      _database=await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //getting directory path for both android and ios
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contacts.db';
    //open/create db at the given path
    var contactsdb = await openDatabase(path, version: 1, onCreate: _createDB);
    return contactsdb;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $contactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colFirstName TEXT,'
        '$colLastName TEXT, $colBirthDate TEXT, $colPhoneNo TEXT, $colEmail TEXT, $colGender TEXT)');
  }
  //fetch contact data
  
}
