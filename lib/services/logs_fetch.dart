import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EstablishmentLogs {
  SharedPreferences _establishmentData;
  String _baseUrl = "http://192.168.1.12:3000/api";

  Future logsByDate(String dateTime) async {
    _establishmentData = await SharedPreferences.getInstance();

    var response = await http.post(
      _baseUrl + '/logs/mobile-establishment-logs',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'vtestToken': _establishmentData.getString('vtestToken'),
        'establishmentId': _establishmentData.getString('establishmentId'),
        'dateTime': dateTime
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {"success": false, "message": "An error occurred"};
    }
  }

  Future createLog(String userId) async {
    _establishmentData = await SharedPreferences.getInstance();
    DateTime date = DateTime.now();
    String dateTime = date.toIso8601String() + 'Z';

    var response = await http.post(
      _baseUrl + '/logs/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'vtestToken': _establishmentData.getString('vtestToken'),
        'userId': userId,
        'establishmentId': _establishmentData.getString('establishmentId'),
        'dateTime': dateTime
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {"success": false, "message": "An error occurred"};
    }
  }

  Future userExist(String userId) async {
    _establishmentData = await SharedPreferences.getInstance();

    var response = await http.post(
      _baseUrl + '/users/mobile-individual',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'vtestToken': _establishmentData.getString('vtestToken'),
        'establishmentId': _establishmentData.getString('establishmentId'),
        'userId': userId
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {"success": false, "message": "An error occurred"};
    }
  }
}
