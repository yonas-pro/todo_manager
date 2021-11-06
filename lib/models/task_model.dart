class TaskModel {
  int? id;
  String? title;
  String? description;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? taskTheme;
  int? remind;
  String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.taskTheme,
    this.remind,
    this.repeat,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    taskTheme = json['taskTheme'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['taskTheme'] = taskTheme;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }
}
