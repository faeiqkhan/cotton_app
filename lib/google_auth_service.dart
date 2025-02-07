import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      return user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }
}
