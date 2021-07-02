import 'dart:core';

class MetricModel {
  late int weight;
  DateTime dateTime = DateTime.now();
  late int userId;

  MetricModel(this.weight, this.dateTime);
  MetricModel.emptyConstructor();

  factory MetricModel.fromJson(dynamic json) {
    MetricModel metricModel = MetricModel.emptyConstructor();
    metricModel.userId = json['userId'];
    metricModel.weight = json['weight'];
    metricModel.dateTime = DateTime.parse(json['dateTime'] as String);
    return metricModel;
  }
}
