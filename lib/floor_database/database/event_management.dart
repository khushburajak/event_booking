import 'dart:async';

import 'package:event_booking/floor_database/dao/user_dao.dart';
import 'package:event_booking/floor_database/entities/user_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'event_management.g.dart';

@Database(version: 1, entities: [User])
abstract class EventManagementDatabase extends FloorDatabase {
  UserDAO get userDAO;
}
