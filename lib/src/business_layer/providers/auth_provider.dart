import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/src/business_layer/providers/base_provider.dart';
import 'package:to_do_app/src/data_layer/local_db/user_state_hive_helper.dart';

import '../network/request_response_type.dart';

class AuthProvider extends BaseProvider {
  final db = FirebaseFirestore.instance;
  late UserCredential _userCredential;
  bool _loading = false;

  /// login user with email and password
  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _userCredential = credential;
      UserStateHiveHelper.instance.setLogin();
      UserStateHiveHelper.instance.saveUserId(_userCredential.user!.uid);
      notifyListeners();
      return ResponseTypes.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
    }
    return ResponseTypes.failed;
  }

  /// register user with email and password
  Future<String> registerUser(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _userCredential = credential;
      UserStateHiveHelper.instance.setLogin();
      UserStateHiveHelper.instance.saveUserId(_userCredential.user!.uid);
      notifyListeners();
      //add user to database
      await addUser(_userCredential.user!.email!, password,
          email.split("@").first, _userCredential.user!.uid);
      return ResponseTypes.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    }
    return ResponseTypes.failed;
  }

  ///Add new user into database
  Future<void> addUser(
    String emailAddress,
    String password,
    String username,
    String userId,
  ) async {
    return await db
        .collection('user')
        .doc(userId)
        .set({
          'emailAddress': emailAddress,
          'password': password,
          'username': username,
          'userId': userId,
          'tasks': []
        })
        .then((value) => print("User Added-----"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  UserCredential get userCredential => _userCredential;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
