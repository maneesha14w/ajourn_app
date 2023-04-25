import 'package:ajourn_app/pages/auth/auth_page.dart';
import 'package:ajourn_app/providers/anxiety_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ajourn_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'SourceSansPro'),
        title: 'Ajourn',
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
      ),
    );
  }
}
