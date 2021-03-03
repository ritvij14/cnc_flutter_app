import 'dart:core';

class SymptomModel {
  bool abdominalPain = false;
  bool bloating = false;
  bool nausea = false;
  bool vomiting = false;
  bool constipation = false;
  bool diarrhea = false;
  bool appetiteLoss = false;
  bool stomaProblems = false;
  String other = '';
  DateTime dateTime = DateTime.now();

  SymptomModel(
      bool abdominalPain,
      bool bloating,
      bool nausea,
      bool vomiting,
      bool constipation,
      bool diarrhea,
      bool appetiteLoss,
      bool stomaProblems,
      String other,
      DateTime dateTime) {
    this.abdominalPain = abdominalPain;
    this.bloating = bloating;
    this.nausea = nausea;
    this.vomiting = vomiting;
    this.constipation = constipation;
    this.diarrhea = diarrhea;
    this.appetiteLoss = appetiteLoss;
    this.stomaProblems = stomaProblems;
    this.other = other;
    this.dateTime = dateTime;
  }

  SymptomModel.emptyConstructor();

  factory SymptomModel.fromJson(dynamic json) {
    return SymptomModel(
        (json['abdominalPain'] as bool),
        (json['bloating'] as bool),
        (json['nausea'] as bool),
        (json['vomiting'] as bool),
        (json['constipation'] as bool),
        (json['diarrhea'] as bool),
        (json['appetiteLoss'] as bool),
        (json['stomaProblems'] as bool),
        (json['other'] as String),
        DateTime.parse(json['dateTime'] as String));
  }
}
