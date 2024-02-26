import 'package:event_booking/floor_database/database/event_management.dart';

class DatabaseInstance {
  static DatabaseInstance? _instance;
  DatabaseInstance._();
  static DatabaseInstance get instance => _instance ??= DatabaseInstance._();

  Future<EventManagementDatabase> getDatabaseInstance() async {
    return $FloorEventManagementDatabase
        .databaseBuilder('event_booking.db')
        .build();
  }
}
