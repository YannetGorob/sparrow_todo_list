import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';
import 'package:sparrow_todo_list/feature/domain/entities/task_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_event.dart';

class ImportantTasksWidget extends StatefulWidget {
  final List<GroupEntity> group;
  const ImportantTasksWidget({
    super.key,
    required this.group,
  });

  @override
  State<ImportantTasksWidget> createState() => _ImportantTasksWidgetState();
}

class _ImportantTasksWidgetState extends State<ImportantTasksWidget> {
  // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    List<TaskEntity> importantTasks = [];
    for (var gr in widget.group) {
      importantTasks.addAll(gr.tasks.where((element) => element.isPriority));
    }
    importantTasks =
        importantTasks.where((element) => !element.isDone).toList();

    final height = MediaQuery.of(context).size.height;
    return importantTasks.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Important Tasks".toUpperCase(),
                style: TextStyle(
                    fontSize: 17,
                    color: AppColors.helpTextColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Container(
                height: height * 0.3,
                child: ListView.builder(
                    itemCount: importantTasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: importantTasks[index].isDone,
                          title: Text(
                            importantTasks[index].name,
                            style: TextStyle(fontSize: 20),
                          ),
                          onChanged: (value) {
                            setState(() {
                              BlocProvider.of<TaskBloc>(context, listen: false)
                                  .add(ChangeDoneStatusTaskEvent(
                                      id: importantTasks[index].id,
                                      status: value!));
                              importantTasks[index].isDone = value;
                              print(importantTasks);
                            });
                          },
                        ),
                      );
                    }),
              ),
            ],
          );
  }
}
