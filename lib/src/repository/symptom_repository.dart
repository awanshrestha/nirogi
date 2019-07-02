import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:meta/meta.dart';
import 'package:nirogi/src/constants/env.dart';
import 'package:nirogi/src/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomRepository {
  final client = Client();
  Future<List<Symptom>> getTopSymptoms() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await client.get("$baseUrl/api/symptoms/top", headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw responseData['error'];
      } else {
        return Symptoms.fromJson(jsonDecode(response.body)).symptoms;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Symptom>> getAllSymptoms() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await client.get(
        "$baseUrl/api/symptoms",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw responseData['error'];
      } else {
        return Symptoms.fromJson(jsonDecode(response.body)).symptoms;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Symptom> getSymptom({@required int symptomId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await client.get(
        "$baseUrl/api/disease/$symptomId",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw responseData['error'];
      } else {
        return Symptom.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> addSymptom({@required Symptom symptom}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await client.post(
        "$baseUrl/api/diseases",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: jsonEncode(symptom.toJson()),
      );
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw responseData['error'];
      } else if (responseData.containsKey('message')) {
        return responseData['message'];
      } else {
        throw "Unexpected error occured!";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

final SymptomRepository symptomRepository = SymptomRepository();
