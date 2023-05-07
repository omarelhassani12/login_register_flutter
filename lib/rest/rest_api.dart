import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loginregisternodejs/constant/utils.dart';

Future<Map<String, dynamic>> userLogin(String email, String password) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/user/login'),
    headers: {"Content-Type": "application/json;charset=UTF-8"},
    body: jsonEncode({'email': email, 'password': password}),
  );
  print('ffff');
  final decodedData = jsonDecode(response.body) as Map<String, dynamic>;

  return decodedData;
}

Future userRegister(String username, String email, String password) async {
  print('gfhghf');
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/user/register'),
    headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8"
    },
    body: jsonEncode({
      'name': username,
      'email': email,
      'password': password,
    }),
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;
}
