import 'package:sqflite/sqflite.dart';
import 'dart:developer';

import '../constants.dart';
import '../models/condition_model.dart';
import './/core/query_exception_handler.dart';
import './/extensions/string_extension.dart';
import './database_managment.dart';

import '../models/column_model.dart';
import '../models/record_model.dart';
import '../models/table_model.dart';

class QueryBuilder {
  // ~
  static final Database _database = DataBaseManagment.database;

  static Future<void> createTable({
    required TableModel table,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.create());
          log(table.create());
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<List<Map<String, Object?>>> getTablesNames({
    void Function(String)? whenError,
  }) async {
    List<Map<String, Object?>> tables = [];
    await QueryExceptionHandler.handler(
      function: () async {
        tables = await _database.rawQuery(
            "$select name $from $sqlite_master $where type='table' AND name NOT LIKE 'sqlite_%';");
        log(tables.map((row) => row['name'] as String).toList().toString());
        log('----------------------------------');
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );
    return tables;
  }

  static Future<void> addNewColumn({
    required TableModel table,
    required ColumnModel column,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.addColumn(column));
          log(table.addColumn(column));
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<void> renameColumn({
    required TableModel table,
    required String oldName,
    required String newName,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.renameColumn(oldName, newName));
          log(table.renameColumn(oldName, newName));
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<void> updateColumnValue({
    required TableModel table,
    required String columnName,
    required dynamic newColumnValue,
    required ConditionModel condition,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(
              table.updateColumn(columnName, newColumnValue, condition));
          log(table.updateColumn(columnName, newColumnValue, condition));
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<List<String>> getColumnNames(
    String tableName, {
    void Function(String)? whenError,
  }) async {
    List<String> columns = [];
    await QueryExceptionHandler.handler(
      function: () async {
        final result =
            await _database.rawQuery('$pragma $tableInfo($tableName)');
        columns = result.map((row) => row['name'] as String).toList();

        columns.forEach((element) {
          log(element);
        });
        log('----------------------------------');
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );
    return columns;
  }

  static Future<void> renameTable({
    required TableModel table,
    required String newName,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.rename(newName));
          log(table.rename(newName));
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<void> dropTable({
    required TableModel table,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.delete());
          log(table.delete());
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<List<Map<String, Object?>>> rawQuery(
    String query, {
    void Function(String)? whenError,
  }) async {
    List<Map<String, Object?>> list = [];

    await QueryExceptionHandler.handler(
      function: () async {
        list = await _database.rawQuery(query);
        log(query);
        log('----------------------------------');
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );

    return list;
  }

  static Future<List<Map<String, Object?>>> getTableContent({
    required String tableName,
    List<String>? columns,
    ConditionModel? condition,
    void Function(String)? whenError,
  }) async {
    List<Map<String, Object?>> list = [];

    await QueryExceptionHandler.handler(
      function: () async {
        list = await _database.rawQuery(
            '$select ${columns ?? '*'} $from ${tableName.withoutSpaces} ${condition == null ? '' : '{$where ${condition.equalToString}}'}');
        if (list.isNotEmpty) {
          for (var element in list) {
            log(element.toString());
          }
          log('----------------------------------');
        } else {
          log('Table Empty');
        }
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );
    return list;
  }

  static Future<void> insertRecord({
    required TableModel table,
    required RecordModel record,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.insert(table.name, record.toJson());
          log(record.toJson().toString());
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<void> updateRecord({
    required TableModel table,
    required List<RecordItemModel> newRecord,
    required ConditionModel condition,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.updateRecord(newRecord, condition));
          log(table.updateRecord(newRecord, condition));
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<void> deleteRecord({
    required TableModel table,
    required ConditionModel condition,
    void Function(String)? whenError,
  }) async =>
      await QueryExceptionHandler.handler(
        function: () async {
          await _database.execute(table.deleteRecord(condition));
          await _resetAutoIncrement(tableName: table.name);
          log(table.deleteRecord(condition));
          log('----------------------------------');
        },
        whenError: (error) {
          whenError?.call(error);
        },
      );

  static Future<void> _resetAutoIncrement({
    required String tableName,
    void Function(String)? whenError,
  }) async {
    var list = await getTableContent(tableName: tableName);

    await QueryExceptionHandler.handler(
      function: () async {
        if (list.isEmpty) {
          await _database.execute(
              '$deleteFrom $sqliteSequence $where name="${tableName.withoutSpaces}"');
        }
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );
  }
  // ~ join

  static Future<void> join({
    required JoinType type,
    required String rowSelect,
    required String secondTableName,
    required String firstColumnName,
    required String secondColumnName,
    void Function(String)? whenError,
  }) async {
    List<Map<String, Object?>> list = [];
    await QueryExceptionHandler.handler(
      function: () async {
        list = await _database.rawQuery(
            '$rowSelect ${joinMapper[type]} ${secondTableName.withoutSpaces} $on ${firstColumnName.withoutSpaces}=${secondColumnName.withoutSpaces} ');
        log('$rowSelect ${joinMapper[type]} $secondTableName $on $firstColumnName=$secondColumnName ');
        list.forEach((element) {
          log(element.toString());
        });
        log('----------------------------------');
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );
  }

  // ~ union
  static Future<void> union({
    required UnionType type,
    required String firstRowSelect,
    required String secondRowSelect,
    String? orderByColumn,
    void Function(String)? whenError,
  }) async {
    List<Map<String, Object?>> query = [];
    await QueryExceptionHandler.handler(
      function: () async {
        query = await _database.rawQuery(
            '$firstRowSelect ${unionMapper[type]} $secondRowSelect $orderBy $orderByColumn');
        log('$firstRowSelect ${unionMapper[type]} $secondRowSelect');
        query.forEach((element) {
          log(element.toString());
        });
        log('----------------------------------');
      },
      whenError: (error) {
        whenError?.call(error);
      },
    );
  }
}
