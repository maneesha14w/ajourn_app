import 'package:ajourn_app/components/home/entry_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*

H O M E P A G E

*/

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
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Ajourn',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w500),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Your recent Journal's",
                style: TextStyle(fontSize: 16),
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
                            .map((entry) => entryCard(
                                () {},
                                entry['entry_title'],
                                entry['date'],
                                entry['entry_content']))
                            .toList(),
                      );
                    }
                    // *TODO Error might trip due to this else

                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, MediaQuery.of(context).size.height * 0.3, 0, 0),
                      child: const Center(child: Text("No entries Found :(")),
                    );
                  })),
            )
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (context, index) => Container(
            //       height: 200,
            //       margin: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: Colors.grey[200],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton.extended(
        onPressed: signUserOut,
        backgroundColor: Colors.black,
        icon: Icon(Icons.add),
        label: Text(
          'Create Entry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
