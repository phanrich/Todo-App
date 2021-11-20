import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task_model.dart';

class TaskController extends GetxController{
  var _taskList= <TaskModel>[].obs;
  List<TaskModel> get taskList =>_taskList.toList();
  late TextEditingController addTaskController;

  @override
  void onInit() {
    addTaskController = TextEditingController();
    _getData();
    super.onInit();
  }

  void _getData() {
    DatabaseHelper.instance.queryAllRows().then((value) {
      value.forEach((element) {
        _taskList.add(TaskModel(id: element['id'], title: element['title'] , isComplete:element['isComplete']));
      });
    });
  }

  void addData() async {
    await DatabaseHelper.instance
        .insert(TaskModel(title: addTaskController.text , isComplete:false));
    _taskList.insert(
        0, TaskModel(id: _taskList.length, title: addTaskController.text , isComplete: false));
    addTaskController.clear();
    update();
  }

  void updateData(TaskModel model)async{
    await DatabaseHelper.instance.update(model);
    update();
  }
  void deleteTask(int id) async {
    await DatabaseHelper.instance.delete(id);
    _taskList.removeWhere((element) => element.id == id);
    update();
  }
}