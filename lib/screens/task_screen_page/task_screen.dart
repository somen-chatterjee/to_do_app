import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/data_models/task.dart';
import 'package:to_do_app/screens/task_screen_page/widgets/task_list.dart';
import 'package:to_do_app/utils/constants.dart';
import 'package:to_do_app/utils/ui_colors.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).initializeTasks();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: deviceSize.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: UiColors.primary,
            ),
            child: Center(
              child: Text(
                Constants.myTodo,
                style: GoogleFonts.dekko(
                  color: UiColors.white,
                  fontSize: 34.0,
                ),
              ),
            ),
          ),
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            margin: const EdgeInsets.only(
              top: 170.0,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: TaskList(),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _addATaskDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UiColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  child: Text(
                    Constants.addNewTask,
                    style: GoogleFonts.dekko(
                      color: UiColors.white,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addATaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            Constants.addATask,
            style: GoogleFonts.dekko(
              color: UiColors.black,
              fontSize: 24.0,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: Constants.taskTitle,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Constants.taskEnter;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _formKey.currentState!.validate();
                    }
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UiColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      padding: const EdgeInsets.all(5.0),
                    ),
                    child: Text(Constants.cancel),
                  ),
                  Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      return ElevatedButton(
                        onPressed: () {
                          final taskTitle = _taskController.text;
                          if (_formKey.currentState!.validate()) {
                            final task = Task(
                              title: taskTitle,
                              isCompleted: 0,
                            );
                            taskProvider.addTask(task);
                            _taskController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UiColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          padding: const EdgeInsets.all(5.0),
                        ),
                        child: Text(Constants.add),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((value) => _taskController.clear());
  }
}
