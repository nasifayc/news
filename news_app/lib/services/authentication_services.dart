import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/models/user_model.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signupWithEmailAndPassword(UserModel userModel) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: userModel.email,
      password: userModel.password!,
    );

    User? user = userCredential.user;

    if (user != null) {
      // Add the user to Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson());
      return user;
    } else {
      return null;
    }
  }

  Future<User?> signinWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user;
  }

  Future<User?> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (userCredential.additionalUserInfo!.isNewUser) {
        // Add new user to Firestore
        UserModel newUser = UserModel(
            id: user!.uid,
            email: user.email!,
            username: user.displayName!,
            photo: user.photoURL);
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(newUser.toJson());
      }

      return user;
    }
    return null;
  }

  Future<User?> signinWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (userCredential.additionalUserInfo!.isNewUser) {
        UserModel newUser = UserModel(
            id: user!.uid,
            email: user.email!,
            username: user.displayName!,
            photo: user.photoURL);
        // Add new user to Firestore
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(newUser.toJson());
      }

      return user;
    }
    return null;
  }
}
