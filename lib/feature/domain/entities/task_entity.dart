class TaskEntity {
  int id;
  String name;
  String description;
  int taskGroupId;
  bool isDone;
  bool isPriority;
  TaskEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.taskGroupId,
      required this.isDone,
      required this.isPriority});
}
