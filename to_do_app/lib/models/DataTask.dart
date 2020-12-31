import 'package:flutter/material.dart';
import 'Tasks.dart';

import 'package:to_do_app/models/Event.dart';
import 'package:intl/intl.dart';

class ControllerTask extends ChangeNotifier {
  //Task Controller
  List<Task> _myTasks = [];

  int getNumberOfTasks() {
    return _myTasks.length;
  }

  int getNumberOfTaskCompleted() {
    int completedTask = 0;
    for (Task task in _myTasks) {
      if (task.getState() == true) {
        completedTask++;
      }
    }
    return completedTask;
  }

  List<Task> getTasks() {
    return _myTasks;
  }

  void addTasks(Task newTask) {
    _myTasks.insert(0, newTask);
    notifyListeners();
  }

  void deleteTask(int index) {
    _myTasks.removeAt(index);
    notifyListeners();
  }

  void toggleState(int index) {
    _myTasks[index].toggleState();
    notifyListeners();
  }

  //FirebaseController

}