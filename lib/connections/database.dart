import 'dart:async';
import 'dart:io';

import 'package:cnc_flutter_app/models/user_question_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();
  static final DBProvider db = DBProvider._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SQLiteDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE user_questions ("
              "id INTEGER PRIMARY KEY,"
              "user_id INTEGER,"
              "question TEXT,"
              "question_notes TEXT)"
            // "created_date INTEGER,"
            // "updated_date INTEGER"
          );
        });
  }

  newUserQuestion(UserQuestion newUserQuestion) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM user_questions");
    int id = table.first["id"];
    if (id == null){
      id =1;
    }
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into user_questions (id,user_id,question,question_notes)"
            " VALUES (?,?,?,?)",
        [
          id,
          newUserQuestion.user_id,
          newUserQuestion.question,
          newUserQuestion.question_notes
          // newUserQuestion.date_created,
          // newUserQuestion.date_updated
        ]);
    print(id);
    print(newUserQuestion.question);
    getAllUserQuestions(1);
    return raw;
  }

  updateUserQuestion(UserQuestion updatedUserQuestion) async {
    final db = await database;
    print("in update: " + updatedUserQuestion.id.toString());
    print(updatedUserQuestion.question);
    await db.rawUpdate('''
    UPDATE user_questions 
    SET question = ?, question_notes = ? 
    WHERE id = ?
    ''', [updatedUserQuestion.question, updatedUserQuestion.question_notes, updatedUserQuestion.id]);
    // var res = await db.update("user_questions", updatedUserQuestion.toMap(),
    //     where: "id = ?", whereArgs: [updatedUserQuestion.id]);
    // return res;
  }

  // getUserQuestion(int user_id) async {
  //   final db = await database;
  //   var res = await db.query("user_questions", where: "user_id = ?", whereArgs: [user_id]);
  //   return res.isNotEmpty ? UserQuestion.fromMap(res.first) : null;
  // }

  Future<List> getAllUserQuestions(int user_id) async {
    final db = await database;
    var questions = await db.rawQuery(    'SELECT * FROM user_questions WHERE user_id = ?', [user_id]);
   print("in get all users: "+ questions.length.toString());
    return questions;
  }

  deleteUserQuestion(int id) async {
    final db = await database;
    return db.delete("user_questions", where: "id = ?", whereArgs: [id]);
  }

  deleteAllUserQuestions(int user_id) async {
    final db = await database;
    db.delete('user_questions', where: 'user_id = ?', whereArgs: [user_id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from user_questions");
  }
}
