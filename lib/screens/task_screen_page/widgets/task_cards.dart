import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data_models/task.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/utils/constants.dart';
import 'package:to_do_app/utils/ui_colors.dart';

class TaskCards extends StatelessWidget {
  final Task task;

  const TaskCards({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title!),
          Text(
            task.isCompleted! == 0 ? Constants.pending : Constants.completed,
            style: GoogleFonts.dekko(
              color: task.isCompleted! == 0 ? UiColors.orange : UiColors.green,
              fontSize: 14.0,
            ),
          )
        ],
      ),
      leading: IgnorePointer(
        ignoring: task.isCompleted! == 0 ? false : true,
        child: Checkbox(
          value: task.isCompleted == 0 ? false : true,
          onChanged: (value) {
            _showCompleteTaskDialog(context, task);
          },
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: UiColors.red,
        ),
        onPressed: () {
          _showDeleteTaskDialog(context, task);
        },
      ),
    );
  }

  void _showCompleteTaskDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Constants.completeTask,
            style: GoogleFonts.dekko(
              color: UiColors.black,
              fontSize: 24.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${Constants.task} ${task.title}'),
              const SizedBox(height: 16.0),
              Text(Constants.completeConfirmation),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UiColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      padding: const EdgeInsets.all(5.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Constants.no),
                  ),
                  Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UiColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                        ),
                        onPressed: () {
                          taskProvider.toggleTaskCompletion(task);
                          Navigator.of(context).pop();
                        },
                        child: Text(Constants.yes),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteTaskDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            Constants.deleteTask,
            style: GoogleFonts.dekko(
              color: UiColors.black,
              fontSize: 24.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${Constants.task} ${task.title}'),
              const SizedBox(height: 16.0),
              Text(
                Constants.deleteConfirmation,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UiColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      padding: const EdgeInsets.all(5.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Constants.no),
                  ),
                  Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UiColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                        ),
                        onPressed: () {
                          taskProvider.deleteTask(task);
                          Navigator.of(context).pop();
                        },
                        child: Text(Constants.yes),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
