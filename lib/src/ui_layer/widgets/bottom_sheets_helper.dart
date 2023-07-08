import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/src/data_layer/res/app_colors.dart';
import 'package:to_do_app/src/data_layer/res/styles.dart';

class AppBottomSheets {
  static Future<dynamic> openActionSheet(
    BuildContext context,
    Widget child,
  ) async {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  static Future<dynamic> openBottomSheet(
    BuildContext context,
    Widget child, {
    bool isDismissible = true,
    bool enableDrag = true,
    bool scrollControlled = true,
    EdgeInsetsGeometry? padding,
  }) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: scrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: AppColors.whiteColor.withOpacity(0.7),
      shape: AppStyles.bottomSheetTopCornersShape(),
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return isDismissible;
          },
          child: ClipRRect(
            borderRadius: AppStyles.br20,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: AppColors.whiteColor,
                padding: AppStyles.screenHorizontalPadding,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
