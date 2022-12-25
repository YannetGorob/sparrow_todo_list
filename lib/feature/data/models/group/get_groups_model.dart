import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';
import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({required id, required name, required description, required tasks})
      : super(id: id, name: name, description: description, tasks: tasks);

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'] as String,
      description: json['description'] as String,
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskModel.fromJson(e))
          .toList(),
    );
  }
}
