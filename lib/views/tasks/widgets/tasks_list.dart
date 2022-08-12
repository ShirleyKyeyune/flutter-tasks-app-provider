import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/view_models/tasks/tasks_view_model.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    TasksViewModel tasksViewModel = context.watch<TasksViewModel>();

    return Expanded(
      child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            var task = tasksList[index];
            return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  tasksViewModel.onUpdateTask(task: task);
                },
              ),
              onLongPress: () => tasksViewModel.onDeleteTask(task: task),
            );
          }),
    );
  }
}
