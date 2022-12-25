import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/domain/entities/task_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_event.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListOfTasksBody extends StatefulWidget {
  List<TaskEntity> task;
  ListOfTasksBody({
    super.key,
    required this.task,
  });

  @override
  State<ListOfTasksBody> createState() => _ListOfTasksBodyState();
}

class _ListOfTasksBodyState extends State<ListOfTasksBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.task.length,
        itemBuilder: (context, index) {
          bool value = widget.task[index].isDone;
          bool priorityValue = !widget.task[index].isPriority;
          return Card(
            child: Slidable(
                startActionPane: ActionPane(motion: DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      BlocProvider.of<TaskBloc>(context, listen: false).add(
                          ChangePriorityStatusTask(
                              id: widget.task[index].id,
                              status: priorityValue));
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: widget.task[index].isPriority
                        ? Icons.push_pin
                        : Icons.push_pin_rounded,
                    label: widget.task[index].isPriority ? 'Unpin' : 'Pin',
                  ),
                ]),
                endActionPane: ActionPane(motion: DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      BlocProvider.of<TaskBloc>(context, listen: false)
                          .add(DeleteTaskEvent(
                        id: widget.task[index].id,
                      ));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ]),
                child: buildListTile(value, index, priorityValue)),
          );
        });
  }

  Widget buildListTile(bool value, int index, bool priorityValue) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: CheckboxListTile(
          secondary: priorityValue ? null : Icon(Icons.push_pin_outlined),
          controlAffinity: ListTileControlAffinity.leading,
          value: value,
          title: Text(widget.task[index].name,
              style: value == false
                  ? TextStyle(color: AppColors.mainTextColor, fontSize: 20)
                  : TextStyle(
                      color: AppColors.helpTextColor,
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough)),
          subtitle: widget.task[index].description.isNotEmpty
              ? Text(widget.task[index].description,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.helpTextColor,
                  ))
              : null,
          onChanged: (value) {
            setState(() {
              BlocProvider.of<TaskBloc>(context, listen: false).add(
                  ChangeDoneStatusTaskEvent(
                      id: widget.task[index].id, status: value!));
            });
          },
          activeColor: AppColors.mainColor,
        ),
      );
}

void doNothing(BuildContext context) {}
