import 'dart:convert';

import 'package:cnc_flutter_app/models/symptom_model.dart';

import 'db_helper.dart';
import 'package:http/http.dart' as http;

class SymptomDBHelper extends DBHelper {
  Future<http.Response> saveNewSymptom(SymptomModel symptomModel) async {
    var requestUrl = baseUrl + 'api/symptom/add/';
    var uriResponse = await http.post(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'abdominalPain': symptomModel.abdominalPain,
          'appetiteLoss': symptomModel.appetiteLoss,
          'constipation': symptomModel.constipation,
          'bloating': symptomModel.bloating,
          'diarrhea': symptomModel.diarrhea,
          'nausea': symptomModel.nausea,
          'stomaProblems': symptomModel.stomaProblems,
          'vomiting': symptomModel.vomiting,
          'other': symptomModel.other,
          'dateTime': symptomModel.dateTime.toIso8601String(),
          'userId': symptomModel.userId.toString(),

        }));
    return uriResponse;
  }

  Future<http.Response> getAllSymptoms() async {
    print('here');
    var requestUrl = baseUrl + 'api/symptom/all';
    http.Response response =
        await http.get(Uri.encodeFull(requestUrl), headers: {});
    return response;
  }

  Future<http.Response> getSymptoms(int userId) async {
    print('inside symptom db helper get symptoms by user id');
    var queryParameters = {
      'userId': userId.toString(),
    };
    var uri =
    Uri.https('10.0.2.2:7777', '/api/symptom/all/user', queryParameters);

    var response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<http.Response> updateExistingSymptom(SymptomModel symptomModel) async {
    var requestUrl = baseUrl + 'api/symptom/update/';
    var uriResponse = await http.put(requestUrl,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'id': symptomModel.id,
          'abdominalPain': symptomModel.abdominalPain,
          'appetiteLoss': symptomModel.appetiteLoss,
          'constipation': symptomModel.constipation,
          'bloating': symptomModel.bloating,
          'diarrhea': symptomModel.diarrhea,
          'nausea': symptomModel.nausea,
          'stomaProblems': symptomModel.stomaProblems,
          'vomiting': symptomModel.vomiting,
          'other': symptomModel.other,
          'dateTime': symptomModel.dateTime.toIso8601String(),
          'userId': symptomModel.userId.toString(),
        }));
  }
}
