import 'file:///C:/Workspace/Capstone/cnc_flutter_app/lib/widgets/fitness_tracking_widgets/fitness_tracking_list_tile_widget.dart';

class FitnessActivityModel {
  String type;
  int minutes;
  int intensity;
  int calories;

  //intensity can be a scale, 1-5
  FitnessActivityModel(String type, int minutes, int intensity) {
    this.type = type;
    this.minutes = minutes;
    this.intensity = intensity;
    this.calories = _calculateCalories(type, minutes, intensity);
  }

  FitnessActivityModel.emptyConstructor() {
    this.minutes = 0;
  }

  int _calculateCalories(String type, int minutes, int intensity) {
    return minutes * intensity;
  }

  int getCalories() {
    return minutes * intensity;
  }

  factory FitnessActivityModel.fromJson(dynamic json) {
    print(json.toString());
    return FitnessActivityModel(json['type'] as String, int.parse((json['minutes'] as String)),
        int.parse(json['intensity'] as String));
  }
}

final List<FitnessActivityModel> fitnessActivityModelList = [
  FitnessActivityModel('running', 10, 5),
  FitnessActivityModel('cycling', 22, 3),
  FitnessActivityModel('swimming', 52, 4),
  FitnessActivityModel('running', 4, 5),
  FitnessActivityModel('hiking', 100, 2),
  FitnessActivityModel('running', 50, 3),
  FitnessActivityModel('running', 63, 4),
  FitnessActivityModel('walking', 10, 2),
  FitnessActivityModel('jogging', 10, 2),
  FitnessActivityModel('jogging', 10, 2),
  FitnessActivityModel('jogging', 20, 3),
];
