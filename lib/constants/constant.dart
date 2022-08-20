import '../database/event_database.dart';
import '../model/event.dart';

class Constants {
  static List<Event> events = [];

  static double income = 0;
  static double expense = 0;

  static Future readAll() async {
    final data = await EventDatabase.instance.queryAll();
    events.clear();
    income = 0;
    expense = 0;
    if (data != null) {
      events = data;
      if (events.isNotEmpty) {
        for (var event in events) {
          if (event.type == 'Income') {
            income += int.parse(event.amount);
          } else {
            expense += int.parse(event.amount);
          }
        }
      }
    } else {
      events = [];
    }
  }
}