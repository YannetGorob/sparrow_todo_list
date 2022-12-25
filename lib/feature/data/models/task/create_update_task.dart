class CreateUpdateTask {
  final String name;
  final String description;
  final int taskGroupId;
  CreateUpdateTask(
      {required this.name,
      required this.description,
      required this.taskGroupId});

  factory CreateUpdateTask.fromJson(Map<String, dynamic> json) {
    return CreateUpdateTask(
      name: json['name'],
      description: json['description'],
      taskGroupId: json['taskGroupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'taskGroupId': taskGroupId,
    };
  }
}
