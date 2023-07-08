import 'package:to_do_app/src/business_layer/localization/translations.dart';
import 'package:to_do_app/src/data_layer/res/regex.dart';

class Validator {
  /// Method used to check validate email text field
  static String? checkLoginEmailErrorMessage(String email) {
    if (email.trim().isEmpty) {
      return AppLocalizations.current.getEmailIsReq;
    } else if (email.isNotEmpty && !AppRegex.emailRegex.hasMatch(email)) {
      return AppLocalizations.current.getInvalidEmailFormat;
    }
    return null;
  }

  /// Method used to check validate password text field
  static String? checkLoginPasswordErrorMessage(String password) {
    if (password.isEmpty) {
      return AppLocalizations.current.getPasswordIsReq;
    } else if (password.isNotEmpty &&
        !AppRegex.hasAllNecessaryField(password)) {
      return AppLocalizations.current.getInvalidPasswordFormat;
    }
    return null;
  }

  /// Method used to check validate password text field
  static String? checkCnfPasswordErrorMessage(String cnfPwd, String password) {
    if (cnfPwd.isEmpty) {
      return AppLocalizations.current.getCnfPwdReq;
    } else if (password.isNotEmpty && cnfPwd != password) {
      return AppLocalizations.current.cnfPwdMustBeSame;
    }
    return null;
  }

  /// check description field
  static String? descriptionFieldValidation(String desc) {
    if (desc.trim().isEmpty) {
      return "Description is required";
    }
    return null;
  }

  /// check title validation
  static String? titleFieldValidation(String title) {
    if (title.trim().isEmpty) {
      return "Title is required";
    }
    return null;
  }

  /// Method used to check validate email text field
  static String? checkLNameErrorMessage(String lName) {
    if (lName.trim().isEmpty) {
      return AppLocalizations.current.getLNameIsReq;
    }
    return null;
  }
}
