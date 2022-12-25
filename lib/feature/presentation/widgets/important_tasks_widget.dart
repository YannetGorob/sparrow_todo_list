import 'package:flutter/material.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';
import 'package:sparrow_todo_list/feature/domain/entities/task_entity.dart';

class ImportantTasksWidget extends StatelessWidget {
  final List<GroupEntity> group;
  const ImportantTasksWidget({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    final List<TaskEntity> importantTasks = [];
    for (var gr in group) {
      importantTasks.addAll(gr.tasks.where((element) => element.isPriority));
    }

    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      child: ListView.builder(
          itemCount: importantTasks.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.secondMainColor,
                ),
                title: Text(importantTasks[index].name, style: TextStyle(fontSize: 20),),
              ),
            );
          }),
    );
  }
}
