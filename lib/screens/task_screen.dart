import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task_model.dart';

class TaskScreen extends StatelessWidget {
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Todo List")),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                  controller: _taskController.addTaskController,
                  decoration: InputDecoration(hintText: "Enter a task"),
                )),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_taskController.addTaskController.text.isEmpty) {
                        Get.snackbar(
                            "Warring", "You need to input your title task.");
                      } else {
                        _taskController.addData();
                        Get.snackbar("Message",
                            "Add Task ${_taskController.addTaskController.text} Success.");
                      }
                    })
              ],
            ),
            Expanded(
              child: GetBuilder(
                  init: TaskController(),
                  builder: (controller) {
                    return ListView.builder(
                        itemCount: _taskController.taskList.length,
                        itemBuilder: (context, index) {
                          TaskModel taskModel = _taskController.taskList[index];
                          return Card(
                              color: taskModel.isComplete == true
                                  ? Colors.lightBlue
                                  : Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "${taskModel.title!}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    taskModel.isComplete == true
                                        ? Text("Complete",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ))
                                        : Text("InComplete",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                    Expanded(
                                      child: CheckboxListTile(
                                        value: taskModel.isComplete,
                                        onChanged: (value) {
                                          taskModel.isComplete = value;
                                          _taskController.updateData(taskModel);
                                          Get.snackbar("Message",
                                              "Your Task is${_taskController.taskList[index].title} ${taskModel.isComplete == true ? "Complete" : "Incomplete"}");
                                          print(taskModel.isComplete);
                                        },
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _taskController.deleteTask(
                                              _taskController
                                                  .taskList[index].id!);
                                          Get.snackbar("Message",
                                              "Add Task ${_taskController.taskList[index].title} Success.");
                                        }),
                                  ],
                                ),
                              ));
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
