import './/extensions/string_extension.dart';

import '../constants.dart';

class ForeignKeyModel {
  ForeignKeyModel({
    required this.fkColumnName,
    required this.pkColumnName,
    required this.pkTableName,
  });
  String fkColumnName;
  String pkColumnName;
  String pkTableName;
  String get foreignKeyToString =>
      '$foreignKey (${fkColumnName.withoutSpaces}) $references ${pkTableName.withoutSpaces}(${pkColumnName.withoutSpaces})  ';

  static String foreignKeysToString(List<ForeignKeyModel> keys) {
    String keysString = '';
    for (ForeignKeyModel k in keys) {
      keysString += '${k.foreignKeyToString} ,';
    }
    return keysString.substring(0, keysString.length - 2);
  }
}
