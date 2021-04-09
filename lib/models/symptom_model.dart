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
  int id;
  DateTime dateTime = DateTime.now();
  int userId;


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
    SymptomModel symptomModel = SymptomModel.emptyConstructor();
    symptomModel.abdominalPain = (json['abdominalPain'] as bool);
    symptomModel.bloating = (json['bloating'] as bool);
    symptomModel.nausea = (json['nausea'] as bool);
    symptomModel.vomiting = (json['vomiting'] as bool);
    symptomModel.constipation = (json['constipation'] as bool);
    symptomModel.diarrhea = (json['diarrhea'] as bool);
    symptomModel.appetiteLoss = (json['appetiteLoss'] as bool);
    symptomModel.stomaProblems = (json['stomaProblems'] as bool);
    symptomModel.other = (json['other'] as String);
    symptomModel.id = json['id'];
    symptomModel.dateTime = (DateTime.parse(json['dateTime'] as String));
    return symptomModel;

    // return SymptomModel(
    //     (json['abdominalPain'] as bool),
    //     (json['bloating'] as bool),
    //     (json['nausea'] as bool),
    //     (json['vomiting'] as bool),
    //     (json['constipation'] as bool),
    //     (json['diarrhea'] as bool),
    //     (json['appetiteLoss'] as bool),
    //     (json['stomaProblems'] as bool),
    //     (json['other'] as String),
    //     DateTime.parse(json['dateTime'] as String));
  }
}
