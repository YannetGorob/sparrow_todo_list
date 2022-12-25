import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';

class GroupEntity {
  final int id;
  final String name;
  final String description;
  List<TaskModel> tasks;
  GroupEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.tasks});
}
