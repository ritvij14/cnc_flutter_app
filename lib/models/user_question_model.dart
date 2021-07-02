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
  int userId;
  String question;
  String questionNotes;
  String dateCreated;
  String dateUpdated;
  int isAnswered;

  UserQuestion(
      {required this.id,
      required this.userId,
      required this.question,
      required this.questionNotes,
      required this.dateCreated,
      required this.dateUpdated,
      required this.isAnswered});

  factory UserQuestion.fromMap(Map<String, dynamic> json) => new UserQuestion(
        id: json["id"],
        userId: json["user_id"],
        question: json["question"],
        questionNotes: json["question_notes"],
        dateCreated: json["date_created"],
        dateUpdated: json["date_updated"],
        isAnswered: json["is_answered"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "question": question,
        "question_notes": questionNotes,
        "date_created": dateCreated,
        "date_updated": dateUpdated,
        "is_answered": isAnswered,
      };
}
