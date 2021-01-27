import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  Future getUserId() async {
    try {
      if (_user == null) {
        UserCredential result = await _auth.signInAnonymously();
        _user = result.user;
      }
      return _user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
