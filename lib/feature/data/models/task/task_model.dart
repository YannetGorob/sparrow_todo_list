import 'package:sparrow_todo_list/feature/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel(
      {required id,
      required name,
      required description,
      required taskGroupId,
      required isDone,
      required isPriority})
      : super(
            id: id,
            name: name,
            description: description,
            taskGroupId: taskGroupId,
            isDone: isDone,
            isPriority: isPriority);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        name: json['name'] as String,
        description: json['description'] as String,
        taskGroupId: json['taskGroupId'],
        isDone: json['isDone'],
        isPriority: json['isPriority']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'taskGroupId': taskGroupId,
      'isDone': isDone,
      'isPriority': isPriority,
    };
  }
}
