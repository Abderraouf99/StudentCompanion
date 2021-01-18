import 'package:flutter/material.dart';
import 'Tasks.dart';

class TaskController extends ChangeNotifier {
  //Task Controller
  List<Task> _myTasks = [];
  List<Task> _archived = [];
  List<Task> _deleted = [];

  List get archived => _archived;
  List get deleted => _deleted;
  Task _task1;

  Task getTask() {
    return _task1;
  }

  void setArchived(List<Task> archive) {
    _archived = archive;
  }

  void setDeleted(List<Task> deleted) {
    _deleted = deleted;
  }

  String get task => _task1.getTask();

  void setTasks(List<Task> taskList) {
    _myTasks = taskList;
  }

  void setTask(String task) {
    _task1 = Task(task: task);
  }

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
    _myTasks.add(newTask);
    notifyListeners();
  }

  void moveTobin(int index, bool isArchived) {
    Task task = (isArchived) ? _archived[index] : _myTasks[index];
    _deleted.add(task);
    (isArchived) ? _archived.removeAt(index) : _myTasks.removeAt(index);
    notifyListeners();
  }
  void unArchiveTask(int index){
    _myTasks.add(_archived[index]);
    _archived.removeAt(index);
    notifyListeners();
  }

  void archiveTask(int index) {
    _archived.add(_myTasks[index]);
    _myTasks.removeAt(index);
    notifyListeners();
  }

  void toggleState(int index, bool isArchived) {
    if (isArchived) {
      _archived[index].toggleState();
      notifyListeners();
    } else {
      _myTasks[index].toggleState();
      notifyListeners();
    }
  }

  void purgeTask(int index) {
    _deleted.removeAt(index);
    notifyListeners();
  }

  void recoverTask(int index) {
    _myTasks.add(_deleted[index]);
    _deleted.removeAt(index);
    notifyListeners();
  }
}
