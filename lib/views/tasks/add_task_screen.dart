import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/util/guid_gen.dart';
import 'package:flutter_tasks_app/view_models/tasks/tasks_view_model.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
                label: Text('Title'), border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          ActionButtons(titleController: titleController),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    TasksViewModel tasksViewModel = context.watch<TasksViewModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              var task = Task(
                id: GUIDGen.generate(),
                title: titleController.text,
              );
              tasksViewModel.onAddTask(task: task);
              Navigator.pop(context);
            },
            child: const Text('Add')),
      ],
    );
  }
}
