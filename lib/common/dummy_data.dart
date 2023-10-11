import '../models/column_model.dart';
import '../models/table_model.dart';

TableModel student = TableModel(
  name: 'Student',
  columns: [
    ColumnModel(
      name: 'studentId',
      isAutoincrement: true,
      isPrimaryKey: true,
      isNotNull: true,
      isInteger: true,
    ),
    ColumnModel(name: 'name', isText: true),
    ColumnModel(name: 'collageId', isInteger: true),
  ],
);

TableModel collage = TableModel(
  name: 'Collage',
  columns: [
    ColumnModel(
      name: 'collageId',
      isAutoincrement: true,
      isPrimaryKey: true,
      isNotNull: true,
      isInteger: true,
    ),
    ColumnModel(name: 'name', isText: true),
    ColumnModel(name: 'address', isText: true),
  ],
);
