import 'dart:convert';

UserQuestion questionsFromJson(String str) {
  final jsonData = json.decode(str);
  return UserQuestion.fromMap(jsonData);
}

String questionsToJson(UserQuestion data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class UserQuestion {
  int id;
  int user_id;
  String question;
  String question_notes;
  String date_created;
   String date_updated;
   int is_answered;

  UserQuestion({
    this.id,
    this.user_id,
    this.question,
    this.question_notes,
    this.date_created,
    this.date_updated,
    this.is_answered
  });

  factory UserQuestion.fromMap(Map<String, dynamic> json) => new UserQuestion(
    id: json["id"],
    user_id: json["user_id"],
    question: json["question"],
    question_notes: json["question_notes"],
    date_created: json["date_created"],
    date_updated: json["date_updated"],
    is_answered: json["is_answered"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": user_id,
    "question": question,
    "question_notes": question_notes,
    "date_created": date_created,
    "date_updated": date_updated,
    "is_answered": is_answered,
  };
}