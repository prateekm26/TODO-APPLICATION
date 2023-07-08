import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/src/business_layer/util/helper/device_info_helper.dart';
import 'package:to_do_app/src/data_layer/res/styles.dart';
import 'package:to_do_app/src/to_do_app.dart';

import 'firebase_options.dart';
import 'src/data_layer/local_db/hive_database_helper.dart';

Future<void> main() async {
  /// Initialize the WidgetFlutterBinding if required
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Sets the status bar color of the widget
  AppStyles.setStatusBarTheme();

  /// Sets Device info
  DeviceInfo.setDeviceId();

  /// Used to initialize hive db and register adapters and generate encryption
  /// key for encrypted hive box
  await HiveHelper.initializeHiveAndRegisterAdapters();
  await SecureStorageHelper.instance.generateEncryptionKey();

  /// Ensuring Size of the phone in UI Design
  await ScreenUtil.ensureScreenSize();

  /// Sets the device orientation of application
  AppStyles.setDeviceOrientationOfApp();

  /// Runs the application in its own error zone
  runApp(const VirtualTourApp());
}
