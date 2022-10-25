import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_gram/features/state/auth/constants/constants.dart';
import 'package:insta_gram/features/state/auth/models/auth_results.dart';
import 'package:insta_gram/features/state/posts/typedefs/user_id.dart';

class Authenticator {
  const Authenticator();

  User? get currentUser => FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;
  String get displayName => currentUser?.displayName ?? '';
  String? get email => currentUser?.email;

  bool get isAlreadyLoggedIn => userId != null;

  Future<AuthResult> loginWithFacebook() async {
    var loginResult = await FacebookAuth.instance.login();

    final token = loginResult.accessToken?.token;

    if (token == null) {
      // user has aborted the login flow
      return AuthResult.aborted;
    }

    final oauthCredential = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final provider =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (provider.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.emailSocpe],
    );

    var signInAccount = await googleSignIn.signIn();

    if (signInAccount == null) {
      return AuthResult.failure;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
