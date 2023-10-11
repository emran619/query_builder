const String createTable = 'CREATE TABLE';
const String alterTable = 'ALTER TABLE';
const String dropTable = 'DROP TABLE';

const String text = 'TEXT';
const String integer = 'INTEGER';
const String boolean = 'BOOLEAN';
const String real = 'REAL';
const String timestamp = 'TIMESTAMP';
const String varchar = 'VARCHAR';
const String references = 'REFERENCES';

// ~ SQL Constrains
const String primaryKey = 'PRIMARY KEY';
const String foreignKey = 'FOREIGN KEY';
const String notNull = 'NOT NULL';
const String unique = 'UNIQUE';
const String autoincrement = 'autoincrement';
const String check = 'CHECK';
const String defaultName = 'DEFAULT';
const String orderBy = 'ORDER BY';

const String add = 'ADD';
const String drop = 'DROP';
const String column = 'COLUMN';
const String renameKey = 'RENAME';
const String update = 'UPDATE';
const String setSql = 'SET';
const String where = 'WHERE';
const String to = 'to';
const String deleteFrom = 'DELETE FROM';
const String select = 'SELECT';
const String from = 'FROM';
const String on = 'ON';
const String sqliteSequence = 'sqlite_sequence';
const String sqlite_master = 'sqlite_master';
const String pragma = 'PRAGMA';
const String tableInfo = 'table_info';

// ~ join
const String innerJoin = 'INNER JOIN';
const String leftJoin = 'LEFT JOIN';
const String rightJoin = 'RIGHT JOIN';
const String fullOuterJoin = 'FULL OUTER JOIN';

enum JoinType {
  inner,
  left,
}

Map<JoinType, String> joinMapper = {
  JoinType.inner: innerJoin,
  JoinType.left: leftJoin,
};

// ~ union
const String union = 'UNION';
const String unionAll = 'UNION ALL';

enum UnionType {
  union,
  unionAll,
}

Map<UnionType, String> unionMapper = {
  UnionType.union: union,
  UnionType.unionAll: unionAll,
};

// ~ condition
enum ConditionType {
  equalTo,
  notEqualTo,
  lessThan,
  lessThanOrEqual,
  upperThan,
  upperThanOrEqual,
}

Map<ConditionType, String> conditionMapper = {
  ConditionType.equalTo: "=",
  ConditionType.notEqualTo: "!=",
  ConditionType.lessThan: "<",
  ConditionType.lessThanOrEqual: "<=",
  ConditionType.upperThan: ">",
  ConditionType.upperThanOrEqual: ">=",
};
