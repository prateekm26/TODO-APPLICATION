import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_app/src/business_layer/util/helper/log_helper.dart';
import 'package:to_do_app/src/data_layer/res/numbers.dart';

class DeviceInfo {
  static double height = 0.0;
  static double width = 0.0;
  static bool smallDevice = false;
  static bool extraLargeDevice = false;
  static String? release;
  static int? sdkInt;
  static String? manufacturer;
  static String? model;
  static String? deviceId = "abc";
  static String? systemName = "ios";
  static String? version;
  static String? name;
  static String data = "";

  /// Method used to set device information's
  static void setDeviceInfo(BuildContext context) async {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    smallDevice = getDeviceSize() == DeviceSize.small ||
        getDeviceSize() == DeviceSize.medium;
    extraLargeDevice = getDeviceSize() == DeviceSize.xlarge ||
        getDeviceSize() == DeviceSize.large;
  }

  static Future<void> setDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        release = androidInfo.version.release;
        sdkInt = androidInfo.version.sdkInt;
        manufacturer = androidInfo.manufacturer;
        model = androidInfo.model;
        deviceId = androidInfo.id;
        systemName = "ANDROID";
        data = androidInfo.data.toString();
        LogHelper.logData(
            'Android $release, ID $deviceId, SDK $sdkInt, $manufacturer $model');
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
        systemName = "IOS";
        version = iosInfo.systemVersion;
        name = iosInfo.name;
        model = iosInfo.model;
        data = iosInfo.data.toString();
        deviceId = iosInfo.identifierForVendor;
        LogHelper.logData('$model, ID $deviceId, $systemName, $version, $name');
      }
    } on Exception catch (e) {
      LogHelper.logError("Error while getting device information's ====> $e");
    }
  }

  static bool isGreaterAndroid12() {
    if (sdkInt != null && sdkInt! > 32) {
      return true;
    }
    return false;
  }

  static bool isBelowAndroid12() {
    if (sdkInt != null && sdkInt! < 31) {
      return true;
    }
    return false;
  }

  /// Method used to return device sizes
  static DeviceSize getDeviceSize() {
    if (height > d_850) {
      //iPhone 12 pro max
      return DeviceSize.xlarge;
    } else if (height > d_800) {
      //iPhone 12 pro
      return DeviceSize.large;
    } else if (height > d_750) {
      //iPhone 8
      return DeviceSize.medium;
    } else {
      //iPhone SE
      return DeviceSize.small;
    }
  }

  /// Method used to check should keyboard open or not
  static bool isKeyBoardOpen(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > d_0) return true;
    return false;
  }
}

enum DeviceSize { small, medium, large, xlarge }
