import 'package:flutter/material.dart';
import 'package:to_do_app/database_helper/database_helper.dart';
import 'package:to_do_app/data_models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
  }

  // Initialize tasks from the database
  Future<void> initializeTasks() async {
    setLoading(true);
    final db = await DatabaseHelper().getDb;
    final taskList = await db.query('Tasks');
    tasks = taskList.map((task) => Task.fromJson(task)).toList();
    setLoading(false);
    notifyListeners();
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    final db = await DatabaseHelper().getDb;
    task.id = await db.insert('Tasks', task.toJson());
    tasks.add(task);
    notifyListeners();
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(Task task) async {
    final db = await DatabaseHelper().getDb;
    task.isCompleted = task.isCompleted! == 0 ? 1 : 0;
    await db
        .update('Tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
    notifyListeners();
  }

  // Delete a task
  Future<void> deleteTask(Task task) async {
    final db = await DatabaseHelper().getDb;
    await db.delete('Tasks', where: 'id = ?', whereArgs: [task.id]);
    tasks.remove(task);
    notifyListeners();
  }
}
