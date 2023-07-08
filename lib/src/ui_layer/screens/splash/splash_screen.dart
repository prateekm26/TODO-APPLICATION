// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/src/business_layer/localization/translations.dart';
import 'package:to_do_app/src/business_layer/util/helper/device_info_helper.dart';
import 'package:to_do_app/src/business_layer/util/helper/log_helper.dart';
import 'package:to_do_app/src/business_layer/util/helper/screen_navigation_helper.dart';
import 'package:to_do_app/src/business_layer/util/helper/util_helper.dart';
import 'package:to_do_app/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:to_do_app/src/data_layer/res/route_names.dart';
import 'package:to_do_app/src/to_do_app.dart';
import 'package:to_do_app/src/ui_layer/screens/home/home_dashboard/home_widget.dart';
import 'package:to_do_app/src/ui_layer/screens/onboarding/login_screen.dart';
import 'package:to_do_app/src/ui_layer/screens/splash/splash_screen_main_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((value) async {
      _onAfterBuild();
    });
  }

  /// Main returning widget which returns the whole UI of screen
  @override
  Widget build(BuildContext context) {
    DeviceInfo.setDeviceInfo(context);
    return _mainWidget(context);
  }

  /// Main UI widget
  Widget _mainWidget(BuildContext context) {
    return const Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SplashScreenMainWidget(),
      ),
    );
  }

  /// Widget called after build one time
  void _onAfterBuild() async {
    Locale locale = await UserStateHiveHelper.instance.getLocale();
    UtilHelper.instance.languageCode = locale.languageCode;
    LogHelper.logData(
        "Selected Locale is =======> ${locale.languageCode}, ${locale.countryCode}");
    await AppLocalizations.load(locale);

    bool isLoggedIn = await UserStateHiveHelper.instance.isLoggedIn();
    if (isLoggedIn) {
      /// Handle after logged in
      navigatorKey.currentState?.pushReplacement(ScreenNavigation.createRoute(
          widget: const HomeScreen(),
          routeNames: RouteNames.homeScreen,
          showPageRoute: true));
    } else {
      /// Handle before logged in
      navigatorKey.currentState?.pushReplacement(ScreenNavigation.createRoute(
          widget: const LoginScreen(),
          routeNames: RouteNames.loginScreen,
          showPageRoute: true));
    }
  }
}
