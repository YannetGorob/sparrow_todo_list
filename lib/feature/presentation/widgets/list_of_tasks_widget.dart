import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/feature/data/models/task/task_model.dart';
import 'package:sparrow_todo_list/feature/domain/entities/task_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_state.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/list_of_tasks_body.dart';

class ListOfTasksWidget extends StatefulWidget {
  final int id;
  ListOfTasksWidget({super.key, required this.id});

  @override
  State<ListOfTasksWidget> createState() => _ListOfTasksWidgetState();
}

class _ListOfTasksWidgetState extends State<ListOfTasksWidget> {
  List<TaskEntity> task = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskBloc>(context, listen: false)
        .add(GetTaskEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(builder: (context, state) {
      if (state is TaskLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TaskLoadedState) {
        if (state.taskmodel is TaskModel) {
          var isExist = task.any((element) => element.id == state.taskmodel.id);
          if (isExist) {
            var index =
                task.indexWhere((element) => element.id == state.taskmodel.id);
            task[index] = state.taskmodel;
          } else {
            task.add(state.taskmodel);
          }
        } else if (state.taskmodel is List<TaskModel>) {
          task = state.taskmodel;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListOfTasksBody(
            task: task,
          ),
        );
      } else if (state is TaskErrorState) {
        return Scaffold(
          body: Center(
            child: Text(
              'Bad result',
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        return Container();
      }
    }, listener: (context, state) {
      if (state is TaskLoadedState &&
          (state.method == 'create' ||
              state.method == 'delete' ||
              state.method == 'changePriorityStatus' ||
              state.method == 'changeStatus')) {
        BlocProvider.of<TaskBloc>(context, listen: false)
            .add(GetTaskEvent(id: widget.id));
      }
    });
  }
}

