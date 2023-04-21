import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

const String link = 'https://ajourn.azurewebsites.net/model_no_sent';
const String username = "\$ajourn";
const String password =
    "dNvxdqLs95ya0rJfvG4Czqxrz6H0XBECwFBBudS6H4meYoW5Rdsfnx2EjinD";
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

class Predictions {
  final dio = Dio();

  void predictResponse(String text) async {
    final response = await dio.post(link,
        data: {'text': text},
        options:
            Options(headers: <String, String>{'authorization': basicAuth}));

    print(response.statusCode);
  }
}
