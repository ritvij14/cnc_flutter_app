import 'food_model.dart';

class FoodLogEntry {
  int _id;
  String _entryTime;
  var _date;
  double _portion;
  Food _food;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  get entryTime => _entryTime;

  Food get food => _food;

  set food(Food value) {
    _food = value;
  }

  @override
  String toString() {
    return 'FoodLogEntry{_entryTime: $_entryTime, _date: $_date, _portion: $_portion, _food: $_food}';
  }

  double get portion => _portion;

  set portion(double value) {
    _portion = value;
  }

  get date => _date;

  set date(value) {
    _date = value;
  }

  set entryTime(value) {
    _entryTime = value;
  }
}
