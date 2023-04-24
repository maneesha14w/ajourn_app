import 'package:ajourn_app/pages/journal/result_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/anxiety_provider.dart';

class JournalReader extends StatefulWidget {
  JournalReader(this.entry, {super.key});
  QueryDocumentSnapshot entry;
  @override
  State<JournalReader> createState() => _JournalReaderState();
}

class _JournalReaderState extends State<JournalReader> {
  @override
  Widget build(BuildContext context) {
    final anxietyProvider =
        Provider.of<AnxietyProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red),
                  ),
                ),
              ],
              onSelected: (value) {
                FirebaseFirestore.instance
                    .collection('Entries')
                    .where('uid', isEqualTo: widget.entry['uid'])
                    .get()
                    .then((querySnapshot) {
                  WriteBatch batch = FirebaseFirestore.instance.batch();
                  querySnapshot.docs.forEach((doc) {
                    batch.delete(doc.reference);
                  });
                  batch.commit();
                  Navigator.pop(context);
                });
              },
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.entry['entry_title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        widget.entry['date'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        widget.entry['entry_content'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 75,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final anxietyProvider =
                Provider.of<AnxietyProvider>(context, listen: false);
            anxietyProvider.currentUid = widget.entry['uid'];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ResultsScreen()),
              ),
            );
          },
          backgroundColor: Colors.black,
          icon: const Icon(Icons.remove_red_eye_sharp),
          label: const Text(
            'View Results',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
