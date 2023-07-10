// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/src/business_layer/localization/translations.dart';
import 'package:to_do_app/src/business_layer/network/request_response_type.dart';
import 'package:to_do_app/src/business_layer/providers/task_provider.dart';
import 'package:to_do_app/src/business_layer/util/helper/date_time_helper.dart';
import 'package:to_do_app/src/business_layer/util/helper/device_info_helper.dart';
import 'package:to_do_app/src/data_layer/models/task_model.dart';
import 'package:to_do_app/src/data_layer/res/app_colors.dart';
import 'package:to_do_app/src/data_layer/res/images.dart';
import 'package:to_do_app/src/data_layer/res/numbers.dart';
import 'package:to_do_app/src/ui_layer/screens/home/add_task/add_task_screen.dart';
import 'package:to_do_app/src/ui_layer/screens/home/view_task/view_task_screen.dart';
import 'package:to_do_app/src/ui_layer/screens/onboarding/login_screen.dart';
import 'package:to_do_app/src/ui_layer/widgets/app_buttons.dart';
import 'package:to_do_app/src/ui_layer/widgets/progress_helper.dart';
import 'package:to_do_app/src/ui_layer/widgets/toast_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskProvider? _taskProvider;
  @override
  void initState() {
    super.initState();
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      _fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
        onPressed: () async {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddTask()))
              .then((value) => _fetchTasks());
        },
      ),
    );
  }

  _bodyWidget() {
    return Consumer<TaskProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          _taskProvider!.checkNullEvent() || _taskProvider!.checkEmptyEvent()
              ? getNoEventsWidget(context)
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => _fetchTasks(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_taskProvider!.taskModel.todayTasks!.isNotEmpty)
                            _title(AppLocalizations.current.today),
                          ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: List.generate(
                                  _taskProvider!.taskModel.todayTasks?.length ??
                                      0,
                                  (index) => _toDoCardWidget(_taskProvider!
                                      .taskModel.todayTasks![index]))),
                          if (_taskProvider!
                              .taskModel.upcommingTasks!.isNotEmpty)
                            _title(AppLocalizations.current.upcoming),
                          ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: List.generate(
                                  _taskProvider!
                                          .taskModel.upcommingTasks?.length ??
                                      0,
                                  (index) => _toDoCardWidget(_taskProvider!
                                      .taskModel.upcommingTasks![index]))),
                          if (_taskProvider!.taskModel.pastTask!.isNotEmpty)
                            _title(AppLocalizations.current.past),
                          ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: List.generate(
                                  _taskProvider!.taskModel.pastTask?.length ??
                                      0,
                                  (index) => _toDoCardWidget(
                                      _taskProvider!.taskModel.pastTask![index],
                                      past: true)))
                        ],
                      ),
                    ),
                  ),
                )
        ],
      );
    });
  }

  _topBar() {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: d_20,
      color: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(d_25),
            bottomRight: Radius.circular(d_25)),
      ),
      child: Container(
        height: 160,
        width: DeviceInfo.width,
        decoration: const BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(d_25),
              bottomRight: Radius.circular(d_25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello\n${_taskProvider!.taskModel.username ?? ""}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: d_24,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    onPressed: _handleLogOut,
                    icon: const Icon(
                      Icons.logout,
                      color: AppColors.whiteColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                DateTimeHelper.getDashboardDayAndDate(
                    DateTime.now().toString()),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: d_16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Widget _toDoCardWidget(Tasks task, {bool past = false}) {
    return Card(
      color: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 1, // Adjust the elevation for shadow effect
      margin: const EdgeInsets.all(16), // Set margin around the card
      child: Padding(
        padding: const EdgeInsets.all(16), // Set padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 60.0),
              child: Text(
                task.title!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            Text(task.description!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.normal)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    DateTimeHelper.getDateFromString(
                        task.date) /*"Thu, 13 Jul 2023"*/,
                    style: Theme.of(context).textTheme.bodySmall),
                Row(
                  children: [
                    if (!past)
                      CommonBorderButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTask(
                                        isComeFromEdit: true,
                                        task: task,
                                      ))).then((value) => _fetchTasks());
                        },
                        label: AppLocalizations.current.edit,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          _deleteTask(task);
                        },
                        icon: const Icon(
                          size: 30,
                          Icons.delete,
                          color: redWarningColor,
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                height: 35,
                width: 110,
                child: CommonButton(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewTaskScreen(
                                task: task,
                              ))),
                  label: AppLocalizations.current.view,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleLogOut() async {
    await _taskProvider!.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _fetchTasks() async {
    Loader.display();
    await _taskProvider!.fetchTasks();
    Loader.close();
  }

  void _deleteTask(Tasks task) async {
    String res = await _taskProvider!.deleteTask(task);
    if (res == ResponseTypes.success) {
      _fetchTasks();
    } else {
      MessageHelper.showSnackBar(context, res);
    }
  }

  Widget getNoEventsWidget(BuildContext context) {
    return SizedBox(
      height: DeviceInfo.height / 2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: AppImages.bigWarningIcon,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                AppLocalizations.current.noTaskAvailable,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: d_12,
                  fontWeight: FontWeight.w500,
                  color: hintTextColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              child: CommonButton(
                onTap: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddTask()))
                      .then((value) => _fetchTasks());
                },
                label: AppLocalizations.current.addTask,
              ),
            )
          ],
        ),
      ),
    );
  }
}
