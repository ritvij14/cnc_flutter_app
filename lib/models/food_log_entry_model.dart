import 'food_model.dart';

class FoodLogEntry {
  late int id;
  late String entryTime;
  var date;
  late double portion;
  late Food food;

  @override
  String toString() {
    return 'FoodLogEntry{entryTime: $entryTime, date: $date, portion: $portion, food: $food}';
  }
}
