import 'dart:core';

class MetricModel{
  int weight;
  DateTime dateTime = DateTime.now();

  MetricModel(int weight, DateTime dateTime){
    this.weight = weight;
    this.dateTime = dateTime;
  }
  MetricModel.emptyConstructor();

  factory MetricModel.fromJson(dynamic json) {
    // MetricModel metricModel = MetricModel.emptyConstructor();
    return MetricModel((json['weight']), DateTime.parse(json['dateTime'] as String));
    // var weightActual = (json['weight']);
    // print(weightActual.runtimeType);
    //
    // return metricModel;

        // int.parse(json['weight'] as String),
        // DateTime.parse(json['dateTime'] as String));
  }
}