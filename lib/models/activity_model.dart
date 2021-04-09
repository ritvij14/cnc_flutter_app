import 'package:cnc_flutter_app/extensions/text_formatting_extension.dart';

class ActivityModel {
  String type;
  int minutes;
  int intensity;
  int mets;
  double metsPerHour;
  int id;
  int userId;
  DateTime dateTime;

  //intensity can be a scale, 1-3; 1 = light, 2 = moderate, 3 = vigorous
  ActivityModel(String type, int minutes, int intensity, DateTime dateTime) {
    this.type = type;
    this.minutes = minutes;
    this.intensity = intensity;
    this.mets = _calculateMets(type, minutes, intensity);
    this.dateTime = dateTime;
  }

  ActivityModel.activityOptions(String type, int intensity) {
    this.type = type;
    this.intensity = intensity;
  }

  ActivityModel.emptyConstructor() {
    this.minutes = 0;
    this.dateTime = new DateTime.now();
  }

  int _calculateMets(String type, int minutes, int intensity) {
    return minutes * intensity;
  }

  int getCalories() {
    return minutes * intensity;
  }

  factory ActivityModel.fromJson(dynamic json) {
    ActivityModel activityModel = ActivityModel.emptyConstructor();
    activityModel.id  = json['id'];
    activityModel.userId  = json['userId'];
    activityModel.type = json['type'] as String;
    activityModel.minutes = int.parse(json['minutes'] as String);
    activityModel.intensity = int.parse(json['intensity'] as String);
    activityModel.dateTime = DateTime.parse(json['dateTime'] as String);

    return activityModel;

        // (json['type'] as String).capitalize(),
        // int.parse((json['minutes'] as String)),
        // int.parse(json['intensity'] as String),
        // symptomModel.id = json['id'],
        // DateTime.parse(json['dateTime'] as String));
  }
}

final List<ActivityModel> fitnessActivityMasterList = [
  ActivityModel.activityOptions("Aerobic Dancing", 3),
  ActivityModel.activityOptions("Archery", 1),
  ActivityModel.activityOptions("Badminton", 2),
  ActivityModel.activityOptions("Baseball", 2),
  ActivityModel.activityOptions("Basketball", 3),
  ActivityModel.activityOptions("Bicycling (easy on flat land)", 2),
  ActivityModel.activityOptions("Bicycling (leisurely)", 2),
  ActivityModel.activityOptions(
      "Bicycling (vigorously on flat land or uphill)", 3),
  ActivityModel.activityOptions("Bowling", 1),
  ActivityModel.activityOptions("Circuit Training (minimal rest)", 3),
  ActivityModel.activityOptions("Cross Country Skiing", 3),
  ActivityModel.activityOptions("Dancing (Ballroom)", 2),
  ActivityModel.activityOptions("Dancing (Popular and Folk)", 2),
  ActivityModel.activityOptions("Football", 3),
  ActivityModel.activityOptions("Gardening (general)", 2),
  ActivityModel.activityOptions(
      "Gardening (heavy continuous digging or hoeing)", 3),
  ActivityModel.activityOptions("Golf (walking, pulling clubs)", 2),
  ActivityModel.activityOptions("Hiking (uphill)", 3),
  ActivityModel.activityOptions("Hockey", 3),
  ActivityModel.activityOptions("Horseshoes", 1),
  ActivityModel.activityOptions("Jogging", 3),
  ActivityModel.activityOptions("Judo", 3),
  ActivityModel.activityOptions("Jumping Rope", 3),
  ActivityModel.activityOptions("Race walking (4.5 mph+)", 3),
  ActivityModel.activityOptions("Roller Skating", 3),
  ActivityModel.activityOptions("Running", 3),
  ActivityModel.activityOptions("Tennis (singles)", 3),
  ActivityModel.activityOptions("Tennis (doubles)", 2),
  ActivityModel.activityOptions("Skiing (alpine)", 2),
  ActivityModel.activityOptions("Soccer (competitive)", 3),
  ActivityModel.activityOptions("Squash", 3),
  ActivityModel.activityOptions("Strolling (slow pace)", 1),
  ActivityModel.activityOptions("Swimming (easy)", 2),
  ActivityModel.activityOptions("Swimming (vigorous pace)", 3),
  ActivityModel.activityOptions("Swimming laps (leisurely pace)", 2),
  ActivityModel.activityOptions("Tennis", 2),
  ActivityModel.activityOptions("Volleyball", 2),
  ActivityModel.activityOptions("Water aerobics", 2),
  ActivityModel.activityOptions("Yoga (Gentle)", 1),

];
