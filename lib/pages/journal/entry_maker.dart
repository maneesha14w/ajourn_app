import 'package:ajourn_app/services/prediction_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EntryMakerScreen extends StatefulWidget {
  const EntryMakerScreen({super.key});

  @override
  State<EntryMakerScreen> createState() => _EntryMakerScreenState();
}

class _EntryMakerScreenState extends State<EntryMakerScreen> {
  String date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  TextEditingController _title_controller = TextEditingController();
  TextEditingController _content_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Create New Journal Entry',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _title_controller,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(date),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _content_controller,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Start Journaling..'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          // Generate a v4 (random) id
          var uuid = const Uuid();
          String id = uuid.v4();
          FirebaseFirestore.instance.collection('Entries').add({
            "entry_title": _title_controller.text,
            "date": date,
            "entry_content": _content_controller.text,
            "uid": id
          }).then((value) {
            Predictions().predictResponse(_content_controller.text, id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Failure in adding entry! due to  $error"));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
