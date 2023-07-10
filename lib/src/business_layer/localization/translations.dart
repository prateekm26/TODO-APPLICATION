import 'package:flutter/widgets.dart';
import 'package:to_do_app/src/business_layer/localization/english_text.dart';

class AppLocalizations {
  static late AppLocalizations current;
  static late Locale locale;

  AppLocalizations._(Locale appLocale) {
    current = this;
  }

  static Future<AppLocalizations> load(Locale appLocale) {
    locale = appLocale;
    return Future.value(AppLocalizations._(appLocale));
  }

  /// Localizations are usually accessed using the InheritedWidget "of" syntax.
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Map of values of supported languages
  static final Map<String, Map<String, String>> _localizedValues = {
    /// English text
    "en": EnglishText.localizationValues,

    /// Dutch text
    'nl': {"title": "Virtual Tour System"},

    /// Dutch text
    'es': {"title": "Virtual Tour System"},

    /// Dutch text
    'de': {"title": "Virtual Tour System"},

    /// Dutch text
    'fr': {"title": "Virtual Tour System"}
  };

  /// Getters of all keys of supported language map
  String get getTitle => _localizedValues[locale.languageCode]?['title'] ?? "";

  String get getEmptyString =>
      _localizedValues[locale.languageCode]?['empty_string'] ?? "";

  String get getApiExceptionMessage =>
      _localizedValues[locale.languageCode]?['api_exception'] ?? "";

  String get getTimeoutExceptionMessage =>
      _localizedValues[locale.languageCode]?['timeout_exception'] ?? "";

  String get getRequestCancelErrorMessage =>
      _localizedValues[locale.languageCode]!['request_cancel_error_message'] ??
      "";

  String get getSocketExceptionMessage =>
      _localizedValues[locale.languageCode]?['socket_exception'] ?? "";

  String get getParseExceptionMessage =>
      _localizedValues[locale.languageCode]?['parse_exception'] ?? "";

  String get getLogin => _localizedValues[locale.languageCode]?['login'] ?? "";
  String get getSignIn =>
      _localizedValues[locale.languageCode]?['signIn'] ?? "";
  String get getSessionExpired =>
      _localizedValues[locale.languageCode]?["session_expired"] ?? "";

  String get getTryAgain =>
      _localizedValues[locale.languageCode]?["try_again"] ?? "";

  String get getOk => _localizedValues[locale.languageCode]?["ok"] ?? "";

  String get getWelcome =>
      _localizedValues[locale.languageCode]?["welcome"] ?? "";

  String get getLoginInfo =>
      _localizedValues[locale.languageCode]?["login_info"] ?? "";

  String get getEmailAddress =>
      _localizedValues[locale.languageCode]?["emailAddress"] ?? "";
  String get dontHaveAccount =>
      _localizedValues[locale.languageCode]?["don'tHaveAccount"] ?? "";
  String get alreadyHaveAc =>
      _localizedValues[locale.languageCode]?["alreadyHaveAc"] ?? "";
  String get signInNow =>
      _localizedValues[locale.languageCode]?["signInNow"] ?? "";
  String get onBoardingSuccess =>
      _localizedValues[locale.languageCode]?["onBoardingSuccess"] ?? "";
  String get signUpNow =>
      _localizedValues[locale.languageCode]?["signUpNow"] ?? "";
  String get signUp => _localizedValues[locale.languageCode]?["signUp"] ?? "";
  String get today => _localizedValues[locale.languageCode]?["today"] ?? "";
  String get upcoming =>
      _localizedValues[locale.languageCode]?["upcoming"] ?? "";
  String get past => _localizedValues[locale.languageCode]?["past"] ?? "";
  String get edit => _localizedValues[locale.languageCode]?["edit"] ?? "";
  String get view => _localizedValues[locale.languageCode]?["view"] ?? "";
  String get addTask => _localizedValues[locale.languageCode]?["addTask"] ?? "";
  String get noTaskAvailable =>
      _localizedValues[locale.languageCode]?["noTaskAvailable"] ?? "";

  String get getEmailIsReq =>
      _localizedValues[locale.languageCode]?["email_is_required"] ?? "";
  String get getCnfPwdReq =>
      _localizedValues[locale.languageCode]?["cnf_pwd_req"] ?? "";

  String get getInvalidEmailFormat =>
      _localizedValues[locale.languageCode]?["invalid_email_format_message"] ??
      "";

  String get getPasswordIsReq =>
      _localizedValues[locale.languageCode]?["password_is_required"] ?? "";

  String get getInvalidPasswordFormat =>
      _localizedValues[locale.languageCode]
          ?["invalid_password_format_message"] ??
      "";

  String get getPassword =>
      _localizedValues[locale.languageCode]?["password"] ?? "";
  String get getConfirmPass =>
      _localizedValues[locale.languageCode]?["getConfirmPass"] ?? "";
  String get getFNameIsReq =>
      _localizedValues[locale.languageCode]?["first_name_req"] ?? "";

  String get getLNameIsReq =>
      _localizedValues[locale.languageCode]?["last_name_req"] ?? "";

  String get getForgotPassword =>
      _localizedValues[locale.languageCode]?["forgot_password"] ?? "";

  String get getQuestionMark =>
      _localizedValues[locale.languageCode]?["question_mark"] ?? "";

  String get getAwesome =>
      _localizedValues[locale.languageCode]?["awesome"] ?? "";

  String get getNext => _localizedValues[locale.languageCode]?["next"] ?? "";

  String get getEnableNotifications =>
      _localizedValues[locale.languageCode]?["enable_notifications"] ?? "";

  String get getBluetooth =>
      _localizedValues[locale.languageCode]?["bluetooth"] ?? "";

  String get getLocation =>
      _localizedValues[locale.languageCode]?["location"] ?? "";

  String get getTermsAndConditions =>
      _localizedValues[locale.languageCode]?["terms_and_conditions"] ?? "";

  String get getTermsAndCondition =>
      _localizedValues[locale.languageCode]?["terms_and_condition"] ?? "";

  String get getReservation =>
      _localizedValues[locale.languageCode]?["reservation"] ?? "";

  String get getSkip => _localizedValues[locale.languageCode]?["skip"] ?? "";

  String get getGotIt => _localizedValues[locale.languageCode]?["got_it"] ?? "";

  String get getNotificationOffTitle =>
      _localizedValues[locale.languageCode]?["notification_off_title"] ?? "";

  String get getNotificationPermissionTitle =>
      _localizedValues[locale.languageCode]?["notification_permission_title"] ??
      "";

  String get getNotificationPermissionDesc =>
      _localizedValues[locale.languageCode]?["notification_permission_desc"] ??
      "";

  String get getNo => _localizedValues[locale.languageCode]?["no"] ?? "";

  String get getYes => _localizedValues[locale.languageCode]?["yes"] ?? "";

  String get getAllowLocation =>
      _localizedValues[locale.languageCode]?["allow_location"] ?? "";

  String get getAllowBluetooth =>
      _localizedValues[locale.languageCode]?["allow_bluetooth"] ?? "";

  String get getHome => _localizedValues[locale.languageCode]?["home"] ?? "";

  String get getReservations =>
      _localizedValues[locale.languageCode]?["reservations"] ?? "";

  String get getMore => _localizedValues[locale.languageCode]?["more"] ?? "";

  String get getLogoutDesc =>
      _localizedValues[locale.languageCode]?["want_to_logout"] ?? "";

  String get getAway => _localizedValues[locale.languageCode]?["away"] ?? "";

  String get getDistanceMeterUnit =>
      _localizedValues[locale.languageCode]?["distance_m_unit"] ?? "";

  String get getDistanceKiloMeterUnit =>
      _localizedValues[locale.languageCode]?["distance_km_unit"] ?? "";

  String get getSubmit =>
      _localizedValues[locale.languageCode]?["submit"] ?? "";

  String get getYour => _localizedValues[locale.languageCode]?["your"] ?? "";

  String get getPasswordResetMessage =>
      _localizedValues[locale.languageCode]?["password_reset_message"] ?? "";

  String get getSomethingWentWrong =>
      _localizedValues[locale.languageCode]!["somethingWentWrong"] ?? "";

  String get getNetworkErrorMessage =>
      _localizedValues[locale.languageCode]!['networkErrorMsg'] ?? "";

  String get getInvalidEmail =>
      _localizedValues[locale.languageCode]!["invalidEmail"] ?? "";

  String get getLogout =>
      _localizedValues[locale.languageCode]?["logout"] ?? "";

  String get getCancel =>
      _localizedValues[locale.languageCode]!["cancel"] ?? "";

  String get getConfirm =>
      _localizedValues[locale.languageCode]!["confirm"] ?? "";

  String get getBluetoothPermissionMessage =>
      _localizedValues[locale.languageCode]!["bluetooth_permission_message"] ??
      "";

  String get getLocationPermissionMessage =>
      _localizedValues[locale.languageCode]!["location_permission_message"] ??
      "";

  String get getLocationServiceMessage =>
      _localizedValues[locale.languageCode]!["location_service_message"] ?? "";

  String get getAvailableVehiclesForYou =>
      _localizedValues[locale.languageCode]!["available_vehicles_for_you"] ??
      "";

  String get getOldPassword =>
      _localizedValues[locale.languageCode]!["old_password"] ?? "";

  String get getEnterOldNewPassword =>
      _localizedValues[locale.languageCode]!["enter_your_old_new_password"] ??
      "";

  String get getEnterEmailAddress =>
      _localizedValues[locale.languageCode]!["enter_email_address"] ?? "";

  String get getEnterPassword =>
      _localizedValues[locale.languageCode]!["enter_password"] ?? "";

  String get getEnterFirstName =>
      _localizedValues[locale.languageCode]!["enter_first_name"] ?? "";

  String get getEnterLastName =>
      _localizedValues[locale.languageCode]!["enter_last_name"] ?? "";

  String get getEditProfile =>
      _localizedValues[locale.languageCode]?["edit_profile"] ?? "";

  String get getSave => _localizedValues[locale.languageCode]?["save"] ?? "";

  String get getViewMore =>
      _localizedValues[locale.languageCode]?["view_more"] ?? "";

  String get getChooseFromGallery =>
      _localizedValues[locale.languageCode]!["choose_from_gallery"] ?? "";

  String get getTakePhotoFromCamera =>
      _localizedValues[locale.languageCode]!["take_photo_from_camera"] ?? "";

  String get getUploadProfilePicture =>
      _localizedValues[locale.languageCode]!["upload_profile_picture"] ?? "";

  String get getBackToHome =>
      _localizedValues[locale.languageCode]?["back_to_home"] ?? "";

  String get getSorry => _localizedValues[locale.languageCode]?["sorry"] ?? "";

  String get getGoToSettings =>
      _localizedValues[locale.languageCode]?["go_to_settings"] ?? "";

  String get getBluetoothEnableMessage =>
      _localizedValues[locale.languageCode]?["bluetooth_enable_message"] ?? "";

  String get getNearbyDevicesPermissionMessage =>
      _localizedValues[locale.languageCode]
          ?["nearby_devices_permission_message"] ??
      "";

  String get getEnableBluetooth =>
      _localizedValues[locale.languageCode]?["enable_bluetooth"] ?? "";

  String get getEnableLocation =>
      _localizedValues[locale.languageCode]?["enable_location"] ?? "";

  String get getAllowNearbyDevices =>
      _localizedValues[locale.languageCode]?["allow_nearby_devices"] ?? "";

  String get getAlert => _localizedValues[locale.languageCode]?["alert"] ?? "";

  String get getRootedDeviceMessage =>
      _localizedValues[locale.languageCode]?["rooted_device_message"] ?? "";

  String get getJailBrokenDeviceMessage =>
      _localizedValues[locale.languageCode]?["jail_broken_device_message"] ??
      "";

  String get getExit => _localizedValues[locale.languageCode]?["exit"] ?? "";

  String get getCamera =>
      _localizedValues[locale.languageCode]?["camera"] ?? "";

  String get getGallery =>
      _localizedValues[locale.languageCode]?["gallery"] ?? "";

  String get getCameraPermissionDesc =>
      _localizedValues[locale.languageCode]?["camera_permission_desc"] ?? "";

  String get getGalleryPermissionDesc =>
      _localizedValues[locale.languageCode]?["gallery_permission_desc"] ?? "";

  String get getUpdateAppInfo =>
      _localizedValues[locale.languageCode]?["update_app_info"] ?? "";

  String get getUpdate =>
      _localizedValues[locale.languageCode]?["update"] ?? "";

  String get getVersion =>
      _localizedValues[locale.languageCode]?["version"] ?? "";

  String get noInternetConnection =>
      _localizedValues[locale.languageCode]?["no_internet_connection"] ?? "";

  String? get cnfPwdMustBeSame =>
      _localizedValues[locale.languageCode]?["cnf_pwd_must_same"] ?? "";
}
