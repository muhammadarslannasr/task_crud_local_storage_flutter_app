import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_task_crud_local_storage/domain/entities/task.dart';
import 'package:flutter_task_crud_local_storage/domain/dao/task_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
