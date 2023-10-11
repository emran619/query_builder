import './../extensions/string_extension.dart';
import './../models/column_model.dart';
import './../models/condition_model.dart';
import './../models/foreign_key_model.dart';
import './../models/record_model.dart';

import '../constants.dart';

class TableModel {
  TableModel({
    required this.name,
    required this.columns,
    this.foreignKeys,
  });
  final String name;
  List<ColumnModel> columns;
  final List<ForeignKeyModel>? foreignKeys;

  // ~ about table

  String create() =>
      '$createTable ${name.withoutSpaces} (${ColumnModel.columnsToString(
        columns: columns,
        foreignKeys: foreignKeys,
      )})';

  String rename(
    String newName,
  ) =>
      '$alterTable $name $renameKey $to ${newName.withoutSpaces}';

  String delete() => '$dropTable $name';

  // ~ about columns

  String addColumn(ColumnModel columnModel) =>
      '$alterTable $name $add ${columnModel.foreignKey == null ? columnModel.columnToString().substring(0, columnModel.columnToString().length - 2) : columnModel.columnToString()}';

  String renameColumn(
    String oldName,
    String newName,
  ) =>
      '$alterTable $name $renameKey $column ${oldName.withoutSpaces} $to ${newName.withoutSpaces}';

  String updateColumn(String columnName, dynamic newColumnValue,
          ConditionModel condition) =>
      '$update $name $setSql $columnName = \'$newColumnValue\' $where ${condition.equalToString}';

  String removeColumn(String columnName) =>
      '$alterTable \'$name\' $drop $column $columnName';

  // ~ about records

  String updateRecord(
    List<RecordItemModel> newRecord,
    ConditionModel condition,
  ) =>
      '$update $name $setSql ${RecordModel.recordList(newRecord)} $where ${condition.equalToString}';

  String deleteRecord(ConditionModel condition) =>
      '$deleteFrom $name $where ${condition.equalToString}';
}
