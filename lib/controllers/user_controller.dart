import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserController extends ChangeNotifier {
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  bool isUserAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<bool> signInWithGoogleWeb() async {
    // Trigger the authentication flow

    // Once signed in, return the UserCredential
    UserCredential user =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
    if (user.user != null) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    return FirebaseAuth.instance.signOut().then((value) => notifyListeners());
  }
}
