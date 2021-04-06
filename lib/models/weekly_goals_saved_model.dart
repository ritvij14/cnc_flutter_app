import 'package:cnc_flutter_app/extensions/text_formatting_extension.dart';

class WeeklySavedGoalsModel {
  int id;
  String type;
  String goalDescription;
  String helpInfo;
  int userId;

  WeeklySavedGoalsModel(int id, String type, String goalDescription, String helpInfo, int userId) {
    this.id = id;
    this.type = type;
    this.goalDescription = goalDescription;
    this.helpInfo = helpInfo;
    this.userId = userId;
  }

  factory  WeeklySavedGoalsModel.fromJson(dynamic json) {
    return  WeeklySavedGoalsModel(json['id'] as int, (json['type'] as String).capitalize(), (json['goal_description'] as String),
        (json['help_info'] as String), (json['user_id']) as int);
  }

  @override
  String toString() {
    return 'WeeklyGoalsModel{id: $id, type: $type, goalDescription: $goalDescription, helpInfo: $helpInfo, userId $userId}';
  }
}
final List< WeeklySavedGoalsModel> weeklySavedGoalsModelList = [];