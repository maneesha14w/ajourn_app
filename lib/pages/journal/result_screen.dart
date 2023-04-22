import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen(this.uid, {super.key});
  final String uid;
  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Entries')
              .where('uid', isEqualTo: widget.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              // iterate through the documents in the QuerySnapshot
              final documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final document =
                      documents[index].data() as Map<String, dynamic>;
                  final anxiety = document['anxiety'] ?? 'unknown';
                  // do something with anxiety
                  return ListTile(
                    title: Text('Anxiety: $anxiety'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
