// ignore_for_file: void_checks

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/src/business_layer/network/request_response_type.dart';
import 'package:to_do_app/src/business_layer/providers/base_provider.dart';
import 'package:to_do_app/src/data_layer/local_db/user_state_hive_helper.dart';
import 'package:to_do_app/src/data_layer/models/task_model.dart';

class TaskProvider extends BaseProvider {
  final db = FirebaseFirestore.instance;
  TaskResModel _taskModel = TaskResModel();

  ///Add new task into database
  Future<String> addTask({required Tasks task}) async {
    final userId = await UserStateHiveHelper.instance.getUserId();
    await db.collection("user").doc(userId).update({
      'tasks': FieldValue.arrayUnion([task.toJson()])
    }).onError((error, stackTrace) {
      return error.toString();
    });
    notifyListeners();
    return ResponseTypes.success;
  }

  ///Edit task into database
  Future<String> editTask({
    required Tasks oldTask,
    required Tasks newTask,
  }) async {
    String res;
    res = await deleteTask(oldTask);
    if (res == ResponseTypes.success) {
      res = await addTask(task: newTask);
    }
    return res;
  }

  /// delete a task
  Future<String> deleteTask(Tasks task) async {
    final userId = await UserStateHiveHelper.instance.getUserId();

    final ref = db.collection("user").doc(userId);
    await ref.update({
      'tasks': FieldValue.arrayRemove([
        Tasks(title: task.title, description: task.description, date: task.date)
            .toJson()
      ])
    }).onError((error, stackTrace) {
      return error.toString();
    });
    notifyListeners();
    return ResponseTypes.success;
  }

  /// fetch all task
  Future<String> fetchTasks() async {
    final userId = await UserStateHiveHelper.instance.getUserId();
    final docRef = db.collection("user").doc(userId);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data();
        final data1 = const JsonEncoder().convert(data);
        _taskModel = TaskResModel.fromJson(json.decode(data1));
        _taskModel.todayTasks!.sort((a, b) {
          DateTime aDate = DateTime.parse(a.date!);
          DateTime bDate = DateTime.parse(b.date!);
          return aDate.compareTo(bDate);
        });
        _taskModel.upcommingTasks!.sort((a, b) {
          DateTime aDate = DateTime.parse(a.date!);
          DateTime bDate = DateTime.parse(b.date!);
          return aDate.compareTo(bDate);
        });
      },
      onError: (e) {
        return "Error getting document: $e";
      },
    );
    notifyListeners();
    return ResponseTypes.success;
  }

  /// getter for task response
  TaskResModel get taskModel => _taskModel;

  /// check if task list is null
  bool checkNullEvent() {
    if (_taskModel.todayTasks == null) {
      return true;
    }
    return false;
  }

  /// check if task list is empty
  bool checkEmptyEvent() {
    if (_taskModel.todayTasks!.isEmpty &&
        _taskModel.upcommingTasks!.isEmpty &&
        _taskModel.pastTask!.isEmpty) {
      return true;
    }
    return false;
  }
}
