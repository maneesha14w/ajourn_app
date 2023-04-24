import 'package:ajourn_app/components/home/drawer.dart';
import 'package:ajourn_app/components/home/entry_card.dart';
import 'package:ajourn_app/pages/journal/entry_reader.dart';
import 'package:ajourn_app/pages/journal/entry_maker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Ajourn',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(22, 30, 30, 30),
              child: Text(
                "Your recent Journal's",
                style: TextStyle(
                    fontSize: 24,
                    //fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("/Entries")
                      .snapshots(),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //check connection state

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((entry) => entryCard(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          JournalReader(entry),
                                    ),
                                  );
                                }, entry['entry_title'], entry['date'],
                                    entry['entry_content']))
                            .toList(),
                      );
                    }

                    return const Center(
                      child: Center(child: Text("No entries Found")),
                    );
                  })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const EntryMakerScreen()),
            ),
          );
        },
        backgroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text(
          'Create Entry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
