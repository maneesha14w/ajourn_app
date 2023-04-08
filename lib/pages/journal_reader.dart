import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JournalReader extends StatefulWidget {
  JournalReader(this.entry, {super.key});
  QueryDocumentSnapshot entry;
  @override
  State<JournalReader> createState() => _JournalReaderState();
}

class _JournalReaderState extends State<JournalReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10, 5, 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.entry['entry_title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "PlayfairDisplay"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.entry['date'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  widget.entry['entry_content'],
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
