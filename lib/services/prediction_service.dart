import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

const String link = 'https://ajourn.azurewebsites.net/model';
const String username = "\$ajourn";
const String password =
    "dNvxdqLs95ya0rJfvG4Czqxrz6H0XBECwFBBudS6H4meYoW5Rdsfnx2EjinD";
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
