class TaskModel {
  int? id;
  String? title;
  bool? isComplete;

  TaskModel({ this.id,  this.title,  this.isComplete});

  Map<String, dynamic> toMap() {
    return {'id': id, "title": title, "isComplete": isComplete};
  }

}