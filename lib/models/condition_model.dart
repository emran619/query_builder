import './/extensions/string_extension.dart';

import '../constants.dart';

class ConditionModel {
  String key;
  ConditionType condition;
  dynamic val;
  ConditionModel({
    required this.key,
    required this.condition,
    required this.val,
  });

  // ~ getters

  String get equalToString =>
      '${key.withoutSpaces}${conditionMapper[condition]}\'$val\'';
}
