
import 'package:cnc_flutter_app/extensions/text_formatting_extension.dart';

class FitnessActivityModel {
  String type;
  int minutes;
  int intensity;
  int calories;
  DateTime dateTime;

  //intensity can be a scale, 1-5
  FitnessActivityModel(String type, int minutes, int intensity, DateTime dateTime) {
    this.type = type;
    this.minutes = minutes;
    this.intensity = intensity;
    this.calories = _calculateCalories(type, minutes, intensity);
    this.dateTime = dateTime;
  }

  FitnessActivityModel.emptyConstructor() {
    this.minutes = 0;
    this.dateTime = new DateTime.now();
  }

  int _calculateCalories(String type, int minutes, int intensity) {
    return minutes * intensity;
  }

  int getCalories() {
    return minutes * intensity;
  }

  factory FitnessActivityModel.fromJson(dynamic json) {
    return FitnessActivityModel((json['type'] as String).capitalize(), int.parse((json['minutes'] as String)),
        int.parse(json['intensity'] as String), DateTime.parse(json['dateTime'] as String));
  }
}
final List<FitnessActivityModel> fitnessActivityModelList = [];