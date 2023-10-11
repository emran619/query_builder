import './/extensions/string_extension.dart';

class RecordModel {
  List<RecordItemModel> data;
  RecordModel({
    required this.data,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    for (RecordItemModel item in data) {
      map.addAll(item.toJson());
    }
    return map;
  }

  static String recordList(List<RecordItemModel> recordList) {
    String stringRecordList = '';
    for (RecordItemModel item in recordList) {
      stringRecordList += '${item.equalToString} ,';
    }
    return stringRecordList.substring(0, stringRecordList.length - 2);
  }
}

class RecordItemModel {
  RecordItemModel({
    required this.columnName,
    required this.value,
  });
  String columnName;
  dynamic value;

  // ~ getters
  Map<String, dynamic> toJson() => {columnName.withoutSpaces: value};

  String get equalToString => '${columnName.withoutSpaces}=\'$value\'';
}
