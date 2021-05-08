import 'dart:convert';
import 'package:http/http.dart' as http;

class Authentication {
  Future signup(
      {String email,
      String establishmentName,
      String address,
      String contactNumber,
      String password}) async {
    var response = await http.post(
      'http://10.0.2.2:3000/api/establishments/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'establishmentName': establishmentName,
        'contactNumber': contactNumber,
        'address': address,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {"success": false};
    }
  }

  Future login({String establishmentId, String password}) async {
    var response = await http.post(
      'http://10.0.2.2:3000/api/establishments/mobile-login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'establishmentId': establishmentId,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      return {"success": false, "message": "An error occurred"};
    }
  }
}
