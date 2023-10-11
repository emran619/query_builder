import './/extensions/bool_extenstions.dart';
import './/extensions/string_extension.dart';
import './/models/foreign_key_model.dart';

import '../constants.dart';

class ColumnModel {
  ColumnModel({
    required this.name,
    this.isPrimaryKey = false,
    this.isNotNull = false,
    this.isAutoincrement = false,
    this.isText = false,
    this.isInteger = false,
    this.isBoolean = false,
    this.isReal = false,
    this.isVarchar = false,
    this.isUnique = false,
    this.foreignKey,
    this.varcharCharCount = 0,
    this.defaultColumnValue,
  });
  final String name;
  bool isPrimaryKey;
  bool isNotNull;
  bool isAutoincrement;
  bool isText;
  bool isInteger;
  bool isBoolean;
  bool isReal;
  bool isVarchar;
  bool isUnique;
  ForeignKeyModel? foreignKey;
  int varcharCharCount;
  dynamic defaultColumnValue;

  // ~ getters

  String get _dataTypes =>
      '${isInteger.then(integer)} ${isText.then(text)} ${isReal.then(real)} ${isBoolean.then(boolean)} ${isVarchar ? '$varchar($varcharCharCount)' : ''}';

  String get _constraints =>
      '${isPrimaryKey.then(primaryKey)} ${isAutoincrement.then(autoincrement)} ${isNotNull.then(notNull)} ${isUnique.then(unique)} ${defaultColumnValue != null ? '$defaultName $defaultColumnValue ' : ''},';

  String columnToString() => foreignKey != null
      ? foreignKey!.foreignKeyToString
      : '${name.withoutSpaces} $_dataTypes $_constraints';

  static String columnsToString({
    required List<ColumnModel> columns,
    List<ForeignKeyModel>? foreignKeys,
    String? condition,
  }) {
    String columnsString = '';
    for (ColumnModel column in columns) {
      columnsString += column.columnToString();
      // ~ fk
      if (foreignKeys != null) {
        columnsString += ',${ForeignKeyModel.foreignKeysToString(foreignKeys)}';
      }
      // ~ condition
      if (condition != null) {
        columnsString += ',$check ($condition)';
      }
    }
    columnsString = columnsString.substring(0, columnsString.length - 1);

    return columnsString;
  }
}
