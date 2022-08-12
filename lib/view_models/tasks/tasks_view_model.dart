import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/util/guid_gen.dart';

class TasksViewModel extends ChangeNotifier {
  final List<Task> allTasks = [];

  void addDefaultTask() {
    allTasks.add(Task(id: GUIDGen.generate(), title: "Task1"));
    notifyListeners();
  }

  void onAddTask({required Task task}) {
    allTasks.add(task);
    notifyListeners();
  }

  void onUpdateTask({required Task task}) {
    final int index = allTasks.indexOf(task);
    allTasks.remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));
    notifyListeners();
  }

  void onDeleteTask({required Task task}) {
    allTasks.remove(task);
    notifyListeners();
  }
}
