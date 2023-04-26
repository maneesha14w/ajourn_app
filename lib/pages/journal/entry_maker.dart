import 'package:ajourn_app/services/prediction_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/common/text_fields.dart';
import '../../providers/anxiety_provider.dart';

class EntryMakerScreen extends StatefulWidget {
  const EntryMakerScreen({super.key});

  @override
  State<EntryMakerScreen> createState() => _EntryMakerScreenState();
}

class _EntryMakerScreenState extends State<EntryMakerScreen> {
  String date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    _contentController.addListener(checkInputLength);
    super.initState();
  }

  void checkInputLength() {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    setState(() {
      if (_contentController.text.length >= 20) {
        myProvider.isEntryBtnDisabled = false;
      } else {
        myProvider.isEntryBtnDisabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
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
          child: MyTextFields(
              titleController: _titleController,
              date: date,
              contentController: _contentController),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: myProvider.isEntryBtnDisabled
            ? null
            : () async {
                // Generate a v4 (random) id
                var uuid = const Uuid();
                String id = uuid.v4();
                FirebaseFirestore.instance.collection('Entries').add({
                  "entry_title": _titleController.text,
                  "date": date,
                  "entry_content": _contentController.text,
                  "uid": id
                }).then((value) {
                  Predictions().predictResponse(_contentController.text, id);
                  Navigator.pop(context);
                }).catchError((error) {
                  Navigator.pop(context);
                });
              },
        child: const Icon(Icons.save),
      ),
    );
  }
}
