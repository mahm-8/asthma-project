class TaskModel {
  int? id;
  String? task;

  TaskModel({this.id, this.task});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;

    return data;
  }
}
