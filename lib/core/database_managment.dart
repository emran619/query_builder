import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';

class DataBaseManagment {
  static late Database database;

  static Future<Database> initDatabase({
    required String dbName,
    int? version,
    FutureOr<void> Function(Database)? onOpen,
    FutureOr<void> Function(Database, int)? onCreate,
    FutureOr<void> Function(Database)? onConfigure,
    FutureOr<void> Function(Database, int, int)? onDowngrade,
    FutureOr<void> Function(Database, int, int)? onUpgrade,
    bool? readOnly = false,
    bool? singleInstance = true,
  }) async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$dbName';
    // open the database
    try {
      database = await openDatabase(
        path,
        version: version,
        onOpen: onOpen,
        onConfigure: onConfigure,
        onDowngrade: onDowngrade,
        onUpgrade: onUpgrade,
        singleInstance: singleInstance,
        readOnly: readOnly,
        onCreate: onCreate,
      );
      print('$dbName  DataBase initialized succeffuly with path $path');
    } catch (e) {
      print(
          'Something went wrong when initializing $dbName  DataBase / error : $e');
    }
    return database;
  }
}
