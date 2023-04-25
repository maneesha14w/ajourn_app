import 'package:ajourn_app/pages/cbt/cbt_page.dart';
import 'package:ajourn_app/pages/home/home_page.dart';
import 'package:ajourn_app/providers/anxiety_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  onTap() {}

  @override
  Widget build(BuildContext context) {
    final anxietyProvider = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const HomePage()),
                ));
          },
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Results',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 15),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Entries')
                .where('uid', isEqualTo: anxietyProvider.currentUid)
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
                    final anxiety = document['anxiety'] ?? 'Pending';
                    final healthAnxiety =
                        document['healthanxiety'] ?? 'Pending';
                    final socialAnxiety =
                        document['socialanxiety'] ?? 'Pending';

                    // do something with anxiety
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          //leading:
                          title: Text('General Anxiety: \n\n $anxiety %',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          title: Text('Health Anxiety: \n\n $healthAnxiety %',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ListTile(
                          title: Text('Social Anxiety: \n\n $socialAnxiety %',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                      ],
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text(
          'Self CBT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const CBTScreen()),
              ));
        },
      ),
    );
  }
}
