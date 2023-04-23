import 'package:ajourn_app/pages/journal/result_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // method to log user out
  void logUserOut(BuildContext context) {
    // pop drawer
    Navigator.pop(context);
    // pop app
    Navigator.pop(context);
    // go back to login page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          // Drawer header
          DrawerHeader(
            child: Center(child: Image.asset('lib/assets/images/logo.png')),
          ),

          const SizedBox(height: 25),
          // LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              onTap: () => signUserOut(),
              title: Text(
                "L O G O U T",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
