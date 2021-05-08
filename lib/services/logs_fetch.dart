import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EstablishmentLogs {
  SharedPreferences _establishmentData;

  Future logsByDate(String dateTime) async {
    _establishmentData = await SharedPreferences.getInstance();

    var response = await http.post(
      'http://10.0.2.2:3000/api/logs/mobile-establishment-logs',
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
}
