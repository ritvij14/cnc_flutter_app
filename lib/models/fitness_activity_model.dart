import 'file:///C:/Workspace/Capstone/cnc_flutter_app/lib/widgets/fitness_tracking_widgets/fitness_tracking_list_tile_widget.dart';

class FitnessActivity {
  String type;
  int minutes;
  int intensity;
  int calories;

  //intensity can be a scale, 1-5
  FitnessActivity(String type, int minutes, int intensity){
    this.type = type;
    this. minutes = minutes;
    this.intensity = intensity;
    this.calories = _calculateCalories(type, minutes, intensity);

  }

  FitnessActivity.emptyConstructor() {
    this.minutes = 0;
  }

  int _calculateCalories(String type, int minutes, int intensity){
    return minutes * intensity;
  }

  int getCalories() {
    return minutes * intensity;
  }
  // factory FitnessActivity.fromJson(Map<String, dynamic> json){
  //   return FitnessActivity();
  //     type: json['type'],
  //     // intensity: json['intensity'],
  //     // minutes: json['minutes'],
  // }
}

final List<FitnessActivity> fitnessActivityModelList = [
  FitnessActivity('running', 10, 5),
  FitnessActivity('cycling', 22, 3),
  FitnessActivity('swimming', 52, 4),
  FitnessActivity('running', 4, 5),
  FitnessActivity('hiking', 100, 2),
  FitnessActivity('running', 50, 3),
  FitnessActivity('running', 63, 4),
  FitnessActivity('walking', 10, 2),
  FitnessActivity('jogging', 10, 2),
  FitnessActivity('jogging', 10, 2),
  FitnessActivity('jogging', 20, 3),


];

