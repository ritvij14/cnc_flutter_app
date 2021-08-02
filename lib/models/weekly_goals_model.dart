import 'package:cnc_flutter_app/extensions/text_formatting_extension.dart';

class WeeklyGoalsModel {
  String type;
  String goalDescription;
  String helpInfo;

  WeeklyGoalsModel(this.type, this.goalDescription, this.helpInfo);

  factory WeeklyGoalsModel.fromJson(dynamic json) {
    return WeeklyGoalsModel((json['type'] as String).capitalize(),
        (json['goal_description'] as String), (json['help_info'] as String));
  }

  @override
  String toString() {
    return 'WeeklyGoalsModel{type: $type, goalDescription: $goalDescription, helpInfo: $helpInfo}';
  }
}

final List<WeeklyGoalsModel> weeklyGoalsModelList = [];
