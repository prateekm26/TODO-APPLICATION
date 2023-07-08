import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:to_do_app/src/business_layer/providers/auth_provider.dart';
import 'package:to_do_app/src/business_layer/providers/base_provider.dart';
import 'package:to_do_app/src/business_layer/providers/task_provider.dart';

class RegisterProviders {
  //Register all providers used in the application here
  static List<SingleChildWidget> providers(BuildContext context) {
    return [
      ChangeNotifierProvider<BaseProvider>(
        create: (context) => BaseProvider(),
      ),
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider<TaskProvider>(
        create: (context) => TaskProvider(),
      ),
    ];
  }
}
