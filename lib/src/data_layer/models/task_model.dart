class TaskResModel {
  String? emailAddress;
  String? password;
  String? userId;
  List<Tasks>? todayTasks;
  List<Tasks>? upcommingTasks;
  List<Tasks>? pastTask;
  String? username;

  TaskResModel(
      {this.emailAddress,
      this.password,
      this.userId,
      this.todayTasks,
      this.upcommingTasks,
      this.username});

  TaskResModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    password = json['password'];
    userId = json['userId'];
    if (json['tasks'] != null) {
      todayTasks = <Tasks>[];
      upcommingTasks = <Tasks>[];
      pastTask = <Tasks>[];
      json['tasks'].forEach((v) {
        Tasks t = Tasks.fromJson(v);
        if (isPastTask(t)) {
          pastTask!.add(t);
        } else if (isTodayTask(t)) {
          todayTasks!.add(t);
        } else {
          upcommingTasks!.add(t);
        }
      });
    }
    username = json['username'];
  }

  bool isTodayTask(Tasks t) {
    DateTime dateTime = DateTime.parse(t.date!);
    if (dateTime.isBefore(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1))) {
      return true;
    }
    return false;
  }

  bool isPastTask(Tasks t) {
    DateTime dateTime = DateTime.parse(t.date!);
    if (dateTime.isBefore(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
      return true;
    }
    return false;
  }
}

class Tasks {
  String? date;
  String? description;
  String? title;

  Tasks({this.date, this.description, this.title});

  Tasks.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['description'] = description;
    data['title'] = title;
    return data;
  }
}
