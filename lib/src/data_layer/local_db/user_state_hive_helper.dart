import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/src/business_layer/util/helper/log_helper.dart';
import 'package:to_do_app/src/data_layer/local_db/hive_database_helper.dart';
import 'package:to_do_app/src/data_layer/res/strings.dart';

/// Helper class to save user information locally on the device
class UserStateHiveHelper {
  UserStateHiveHelper.__internal();

  static final UserStateHiveHelper _instance = UserStateHiveHelper.__internal();

  static UserStateHiveHelper get instance => _instance;

  /// Method used to open user box [Boxes.userBox]
  /// Box is opened only when hive is initialized
  /// Hive already initialized in [main.dart] file
  /// inside main method before [runApp] method is called
  Future<Box<dynamic>> _openHiveBox() async {
    try {
      return await Hive.openBox(
        Boxes.userBox,
        encryptionCipher:
            HiveAesCipher(SecureStorageHelper.instance.decodedKey),
      );
    } catch (e) {
      /// If hive db gives some error then it is initialized and open again
      /// and generate again encryption key for encrypted hive box
      await HiveHelper.initializeHiveAndRegisterAdapters();
      await SecureStorageHelper.instance.generateEncryptionKey();
      return await Hive.openBox(
        Boxes.userBox,
        encryptionCipher:
            HiveAesCipher(SecureStorageHelper.instance.decodedKey),
      );
    }
  }

  /// Method used to close hive box [Boxes.userBox]
  Future<void> close() async {
    _openHiveBox().then((box) {
      box.close();
    });
  }

  /// Method used to set user is logged in inside the box [Boxes.userBox]
  Future<void> setLogin() async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.loggedIn, true);
  }

  /// Method used to check user is logged in or not from the box [Boxes.userBox]
  Future<bool> isLoggedIn() async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    final loggedIn = encryptedBox.get(UserStateKeys.loggedIn);
    return loggedIn ?? false;
  }

  /// Method used to logout and delete data from the box [Boxes.userBox]
  Future<void> logOut() async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.loggedIn, false);
    await _deleteUser();
  }

  /// Method used deleting data from the box [Boxes.userBox]
  Future<void> _deleteUser() async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    // encryptedBox.clear();
    encryptedBox.delete(UserStateKeys.loggedIn);
    // encryptedBox.delete(Boxes.accessToken);
    encryptedBox.delete(UserStateKeys.userData);
    return;
  }

  /// Method used to save user data inside the box [Boxes.userBox]
  Future<void> saveUser(UserCredential? credential) async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.userData, credential);
  }

  /// Method used to save user data inside the box [Boxes.userBox]
  Future<void> saveUserId(String userId) async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.userId, userId);
  }

  /// Method used to get user data from the box [Boxes.userBox]
  Future<UserCredential?> getUser() async {
    UserCredential? credential;
    try {
      final Box<dynamic> encryptedBox = await _openHiveBox();
      credential = encryptedBox.get(UserStateKeys.userData);
    } catch (e) {
      LogHelper.logData("Error while fetching user data from cache ====> $e");
    }
    return credential;
  }

  Future<String?> getUserId() async {
    String? userId;
    try {
      final Box<dynamic> encryptedBox = await _openHiveBox();
      userId = encryptedBox.get(UserStateKeys.userId);
    } catch (e) {
      LogHelper.logData("Error while fetching user data from cache ====> $e");
    }
    return userId;
  }

  /// Method used to check user is logged in or not from the box [Boxes.userBox]
  Future<void> setLocale(Locale locale) async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    encryptedBox.put(UserStateKeys.languageCode, locale.languageCode);
    encryptedBox.put(UserStateKeys.languageCountryCode, locale.countryCode);
  }

  /// Method used to logout and delete data from the box [Boxes.userBox]
  Future<Locale> getLocale() async {
    final Box<dynamic> encryptedBox = await _openHiveBox();
    final languageCode = encryptedBox.get(UserStateKeys.languageCode);
    final languageCountryCode =
        encryptedBox.get(UserStateKeys.languageCountryCode);
    return Locale(
      languageCode ?? LanguageConstants.englishLanguageCode,
      languageCountryCode ?? LanguageConstants.englishCountryCode,
    );
  }
}
