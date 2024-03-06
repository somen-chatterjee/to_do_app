import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/screens/task_screen_page/widgets/task_cards.dart';
import 'package:to_do_app/utils/constants.dart';
import 'package:to_do_app/utils/ui_colors.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final tasks = taskProvider.tasks;
        return Container(
          width: deviceSize.width,
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: UiColors.secondary,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: !taskProvider.loading
              ? tasks.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCards(
                          task: tasks[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 2.0,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        Constants.noTask,
                        style: GoogleFonts.dekko(
                          color: UiColors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    )
              : const Center(
                  child: CircularProgressIndicator(
                    color: UiColors.primary,
                  ),
                ),
        );
      },
    );
  }
}
