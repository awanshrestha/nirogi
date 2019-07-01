import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' show Client;
import 'package:nirogi/src/constants/env.dart';
import 'package:nirogi/src/models/firstaid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstAidRepository {
  final Client client = Client();
  Future<List<Firstaid>> getFirstAids() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response = await client.get("$baseUrl/firstaids", headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw responseData['error'];
      } else {
        return Firstaids.fromJson(jsonDecode(response.body)).firstaids;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Firstaid> getSingleFirstAid({@required int firstAidId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    try {
      final response =
          await client.get("$baseUrl/firstaid/$firstAidId", headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw responseData['error'];
      } else {
        return Firstaid.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
