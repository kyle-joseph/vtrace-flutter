import 'dart:convert';
import 'package:http/http.dart' as http;

class Authentication {
  final String _baseUrl = "http://localhost:3000/api";

  Future<http.Response> signup(
      {String email,
      String establishmentName,
      String address,
      String contactNumber,
      String password}) async {
    var response = http.post(
      Uri.http(_baseUrl, 'create'),
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
  }
}
