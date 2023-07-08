import 'package:flutter/material.dart';
import 'package:to_do_app/src/data_layer/res/app_colors.dart';

class MessageHelper {
  /// Method used to show error messages
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      backgroundColor: AppColors.mainColor,
    ));
  }
}
