import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/view_models/tasks/tasks_view_model.dart';
import 'package:flutter_tasks_app/views/tasks/add_task_screen.dart';
import 'package:flutter_tasks_app/views/tasks/widgets/tasks_list.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  void _addTaskModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddTaskScreen(),
      )),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final tasksViewModel =
          Provider.of<TasksViewModel>(context, listen: false);
      tasksViewModel.addDefaultTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    TasksViewModel tasksViewModel = context.watch<TasksViewModel>();
    List<Task> tasksList = tasksViewModel.allTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks App'),
        actions: [
          IconButton(
            onPressed: () => _addTaskModalBottomSheet(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Chip(
              label: Text(
                'Tasks:',
              ),
            ),
          ),
          TasksList(tasksList: tasksList)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskModalBottomSheet(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
