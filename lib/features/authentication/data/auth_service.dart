import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../frame/presentation/frame_page.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  static loginApple(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      final cred = await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email]);

      if (cred.identityToken == null) {
        if(context.mounted) {
          showMsg(context, "Fail to authorize using apple...");
        }
        return;
      }

      final oAuth = OAuthProvider('apple.com').credential(
          idToken: cred.identityToken, accessToken: cred.authorizationCode);

      await auth.signInWithCredential(oAuth);
      if(context.mounted) {
        successLogin(context, cred.email!);
      }
    } catch (e) {
      if(context.mounted) {
        showMsg(context, e.toString());
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.loaderOverlay.hide();
    });
  }

  static loginGoogle(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      final googleUser =
      await GoogleSignIn(scopes: ['email', 'profile']).signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth?.idToken == null || googleAuth?.accessToken == null) {
        if(context.mounted) {
          showMsg(context, "Fail to authorize using google...");
        }
        return;
      }

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      await auth.signInWithCredential(cred);
      if(context.mounted) {
        successLogin(context, googleUser!.email);
      }
    } catch (e) {
      if(context.mounted) {
        showMsg(context, e.toString());
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.loaderOverlay.hide();
    });
  }

  static createUser(BuildContext context, String username, String email,
      String password) async {
    context.loaderOverlay.show();
    try {
      final ucd = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await ucd.user?.updateDisplayName(username);
      await auth.currentUser?.sendEmailVerification();
      if(context.mounted){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FrameLayer()));
      }
    } on FirebaseAuthException catch (e) {
      if(context.mounted) {
        if (e.code == 'weak-password') {
          showMsg(context,
              "Password is too weak, must be 6 character long...");
        } else if (e.code == 'email-already-in-use') {
          showMsg(context, "Email already exist...");
        } else {
          showMsg(context, e.code.toString());
        }
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.loaderOverlay.hide();
    });
  }

  static login(BuildContext context, String email, String password) async {
    context.loaderOverlay.show();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if(context.mounted) {
        successLogin(context, email);
      }
    } on FirebaseAuthException catch (e) {
      if(context.mounted) {
        if (e.code == "invalid-credential") {
          showMsg(context, "Invalid email or password...");
        } else {
          showMsg(context, e.code.toString());
        }
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.loaderOverlay.hide();
    });
  }

  static resetPassword(BuildContext context, String email) async {
    context.loaderOverlay.show();
    try {
      await auth.sendPasswordResetEmail(email: email);
      if(context.mounted) {
        showMsg(context, "Check your email for password reset link...");
      }
    } on FirebaseAuthException catch (e) {
      if(context.mounted) {
        if (e.code == "invalid-email") {
          showMsg(context, "Invalid email...");
        } else if (e.code == "channel-error") {
          showMsg(context, "Please enter your email...");
        } else {
          showMsg(context, e.code.toString());
        }
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.loaderOverlay.hide();
    });
  }

  static showMsg(context, String mess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text(mess)));
  }

  static successLogin(context, String email) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const FrameLayer()));
  }
}