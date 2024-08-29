import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ontrigo/API/services/api_client.dart';

import '../../../interfaces/auth.dart';
import '../../../models/user_data.dart';
import 'auth_api_service.dart';

class FirebaseAuthService implements AuthService {
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  final FirebaseAuth firebaseAuth;

  FirebaseAuthService({
    required this.googleSignIn,
    required this.facebookAuth,
    required this.firebaseAuth,
  });

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      debugPrint('Google sign-in failed: $e');
    }
    return null;
  }

  @override
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await facebookAuth.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final credential = FacebookAuthProvider.credential(accessToken.tokenString);

        return firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      debugPrint('Facebook sign-in failed: $e');
    }
    return null;
  }

  @override
  Future<UserData?> signUpWithGoogle(BuildContext context) async {
    final UserCredential? userCredential = await signInWithGoogle();
    final String? idToken = await userCredential?.user?.getIdToken();
    
    if (idToken != null) {
      final Map<String, String> payload = {
        "provider": "google",
        "providerToken": idToken,
      };
      // ignore: use_build_context_synchronously
      return ApiServiceImpl(client: ApiClient().client, baseUrl: baseUrl).signUp(context, payload);
    }

    return null;
  }
}
