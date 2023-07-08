// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/src/business_layer/network/request_response_type.dart';
import 'package:to_do_app/src/business_layer/providers/task_provider.dart';
import 'package:to_do_app/src/business_layer/util/helper/date_time_helper.dart';
import 'package:to_do_app/src/business_layer/util/helper/validator.dart';
import 'package:to_do_app/src/data_layer/models/task_model.dart';
import 'package:to_do_app/src/data_layer/res/app_colors.dart';
import 'package:to_do_app/src/ui_layer/widgets/app_buttons.dart';
import 'package:to_do_app/src/ui_layer/widgets/app_text_fields.dart';
import 'package:to_do_app/src/ui_layer/widgets/progress_helper.dart';
import 'package:to_do_app/src/ui_layer/widgets/toast_helper.dart';

class AddTask extends StatefulWidget {
  bool isComeFromEdit;
  Tasks? task;
  AddTask({Key? key, this.isComeFromEdit = false, this.task}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TaskProvider _taskProvider;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _decFocus = FocusNode();
  DateTime _date = DateTime.now();
  @override
  void initState() {
    super.initState();
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _init();
  }

  _init() {
    /// init text fields for edit task
    if (widget.isComeFromEdit && widget.task != null) {
      _date = DateTime.parse(widget.task!.date!);
      _titleController.text = widget.task!.title!;
      _descController.text = widget.task!.description!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    _decFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // un focus text field on tap outside
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          centerTitle: true,
          leading: const CustomBackButton(),
          title: Text(
            widget.isComeFromEdit ? "Edit Task" : "Add Task",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        body: _body(),
        bottomNavigationBar: _submitButton(),
      ),
    );
  }

  /// returns main body widget
  _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateTimeHelper.getDate(_date),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 18)),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      // calender button
                      IconButton(
                          onPressed: openCalender,
                          icon: const Icon(
                            size: 35,
                            Icons.calendar_month_outlined,
                            color: AppColors.mainColor,
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              _titleField(),
              const SizedBox(
                height: 15,
              ),
              _descField(),
            ],
          ),
        ),
      ),
    );
  }

  /// title text field
  _titleField() {
    return CustomTextField(
      controller: _titleController,
      focusNode: _titleFocus,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      showBorders: true,
      hintText: "Title",
      borderColor: AppColors.mainColor,
      maxLength: 30,
      validator: (val) => Validator.titleFieldValidation(val ?? ""),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (val) {
        FocusNode().requestFocus(_decFocus);
      },
    );
  }

  /// description text field
  _descField() {
    return CustomTextField(
      controller: _descController,
      //focusNode: _titleFocus,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      showBorders: true,
      hintText: "Description",
      borderColor: AppColors.mainColor,
      validator: (val) => Validator.descriptionFieldValidation(val ?? ""),
      maxLines: 12,
    );
  }

  /// add/save changes button
  _submitButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CommonButton(
        onTap: () {
          if (_formKey.currentState?.validate() ?? false) {
            widget.isComeFromEdit ? _updateTask() : _addTask();
          }
        },
        label: widget.isComeFromEdit ? "Save" : "Add",
      ),
    );
  }

  /// this method opens a cupertino date picker in a bottom sheet
  openCalender() async {
    DateTime? selectedDate;
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (BuildContext builder) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CupertinoDatePicker(
                    dateOrder: DatePickerDateOrder.dmy,
                    showDayOfWeek: true,
                    minimumDate: DateTime.now(),
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date) {
                      selectedDate = date;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: CommonButton(
                    label: "Done",
                    onTap: () {
                      setState(() {
                        if (selectedDate != null) _date = selectedDate!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          );
        });
  }

  ///add a new task
  void _addTask() async {
    String res = await _taskProvider.addTask(
        task: Tasks(
            title: _titleController.text.trim(),
            description: _descController.text.trim(),
            date: _date.toString()));

    if (res == ResponseTypes.success) {
      Navigator.pop(context);
    } else {
      MessageHelper.showSnackBar(context, res);
    }
  }

  /// edit task handle
  void _updateTask() async {
    Loader.display();
    String res = await _taskProvider.editTask(
        oldTask: widget.task!,
        newTask: Tasks(
            title: _titleController.text.trim(),
            description: _descController.text.trim(),
            date: _date.toString()));
    Loader.close();
    if (res == ResponseTypes.success) {
      Navigator.pop(context);
    } else {
      MessageHelper.showSnackBar(context, res);
    }
  }
}
