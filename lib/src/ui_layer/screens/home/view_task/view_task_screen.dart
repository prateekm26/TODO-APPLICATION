import 'package:flutter/material.dart';
import 'package:to_do_app/src/business_layer/util/helper/date_time_helper.dart';
import 'package:to_do_app/src/data_layer/models/task_model.dart';
import 'package:to_do_app/src/ui_layer/widgets/app_buttons.dart';

class ViewTaskScreen extends StatelessWidget {
  final Tasks? task;
  const ViewTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        // elevation: 0,
        // backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
        title: Text(
          "Task Details",
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _title(task!.title!, context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              DateTimeHelper.getDateFromString(task!.date),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          _description(context)
        ]);
  }

  _title(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 22),
      ),
    );
  }

  _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
      child: Text(
        task!.description!,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18, height: 1.5, fontWeight: FontWeight.normal),
      ),
    );
  }
}
