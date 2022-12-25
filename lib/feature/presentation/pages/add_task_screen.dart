import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/data/models/task/create_update_task.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_event.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.id});
  final int id;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _groupKey = GlobalKey<FormState>();
  TextEditingController newTaskController = TextEditingController();
  TextEditingController newDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _groupKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.mainTextColor,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          shadowColor: Colors.transparent,
                          backgroundColor: AppColors.mainBacgroundColor,
                          side: BorderSide(
                            color: Colors.grey.shade400,
                            width: 2.0,
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        style: TextStyle(fontSize: 25),
                        controller: newTaskController,
                        decoration: InputDecoration(
                            hintText: 'Enter new task',
                            hintStyle: TextStyle(fontSize: 25),
                            border: InputBorder.none),
                      ),
                    ),
                    TextFormField(
                      maxLength: 100,
                      maxLines: 4,
                      style: TextStyle(fontSize: 25),
                      controller: newDescriptionController,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Description',
                          hintStyle: TextStyle(fontSize: 25),
                          border: InputBorder.none),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: newTaskController,
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: value.text.isNotEmpty
                                ? () {
                                    print(newTaskController.text);
                                    print(newDescriptionController.text);
                                    BlocProvider.of<TaskBloc>(context,
                                            listen: false)
                                        .add(CreateTaskEvent(
                                      taskmodel: CreateUpdateTask(
                                          name: newTaskController.text,
                                          description:
                                              newDescriptionController.text,
                                          taskGroupId: widget.id),
                                    ));
                                    Navigator.pop(context);
                                  }
                                : null,
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.00)))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New Task',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.keyboard_arrow_up)
                                ]),
                          ),
                        );
                      },
                    ),
                  ],
                )),
              ))),
    );
  }
}
