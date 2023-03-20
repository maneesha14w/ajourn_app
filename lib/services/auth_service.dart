import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Sign in with google
  signInwithGoogle() async {
    final GoogleSignInAccount? acc = await GoogleSignIn().signIn();

    // get auth details from req
    final GoogleSignInAuthentication gAuth = await acc!.authentication;

    // create credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
