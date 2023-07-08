import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/src/business_layer/localization/translations.dart';
import 'package:to_do_app/src/business_layer/network/request_response_type.dart';
import 'package:to_do_app/src/business_layer/util/helper/internet_helper.dart';
import 'package:to_do_app/src/data_layer/local_db/user_state_hive_helper.dart';

class BaseProvider extends ChangeNotifier {
  /// Method used to check internet connection
  Future<bool> checkInternet() async {
    return await NetworkConnection.instance.checkInternetConnection();
  }

  /// Method used to get exception messages
  String? getExceptionMessage({required ExceptionType exceptionType}) {
    switch (exceptionType) {
      case ExceptionType.apiException:
        return AppLocalizations.current.getApiExceptionMessage;
      case ExceptionType.timeOutException:
        return AppLocalizations.current.getTimeoutExceptionMessage;
      case ExceptionType.socketException:
        return AppLocalizations.current.getSocketExceptionMessage;
      case ExceptionType.parseException:
        return AppLocalizations.current.getParseExceptionMessage;
      case ExceptionType.otherException:
        return AppLocalizations.current.getSomethingWentWrong;
      case ExceptionType.cancelException:
        return AppLocalizations.current.getRequestCancelErrorMessage;
      case ExceptionType.noException:
        return "";
    }
  }

  /// Method used for logout user fro the application

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await UserStateHiveHelper.instance.logOut();
  }

  /// Method used to notify for UI update
  void refreshState() {
    notifyListeners();
  }
}
