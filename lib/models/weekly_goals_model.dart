import 'package:cnc_flutter_app/extensions/text_formatting_extension.dart';

class WeeklyGoalsModel {
  String type;
  String goalDescription;
  String helpInfo;

  WeeklyGoalsModel(String type, String goalDescription, String helpInfo) {
    this.type = type;
    this.goalDescription = goalDescription;
    this.helpInfo = helpInfo;
  }

  factory WeeklyGoalsModel.fromJson(dynamic json) {
    return WeeklyGoalsModel((json['type'] as String).capitalize(), (json['goal_description'] as String),
        (json['help_info'] as String));
  }
}
final List<WeeklyGoalsModel> weeklyGoalsModelList = [];