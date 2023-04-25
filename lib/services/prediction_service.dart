import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

const String link = 'https://ajournapi.azurewebsites.net/model';
const String username = "\$ajournApi";
const String password =
    "9JcAwB1C8KclrAs7ZF4MQM9oGX5sqNsXqlMR01X01c4QxKEoZ6Yy9dCATM6f";
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

class Predictions {
  final dio = Dio();

  void predictResponse(String text, String id) async {
    final response = await dio.post(link,
        data: {'text': text},
        options:
            Options(headers: <String, String>{'authorization': basicAuth}));

    // Extract the anxiety values
    final double healthanxiety = response.data['healthanxiety'];
    final double socialanxiety = response.data['socialanxiety'];
    final double anxiety = response.data['anxiety'];

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Entries')
        .where('uid', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentReference docRef = querySnapshot.docs.first.reference;

      await docRef.update({
        'healthanxiety': healthanxiety,
        'socialanxiety': socialanxiety,
        'anxiety': anxiety,
      });
    }
  }
}
