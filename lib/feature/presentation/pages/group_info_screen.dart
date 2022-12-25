import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_state.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/add_task_screen.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/group_home_screen.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/header_drawer_widget.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/list_of_tasks_widget.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({
    super.key,
    required this.groupName,
    required this.name,
    required this.groupEntity,
  });
  final String groupName;
  final String name;
  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.secondMainColor,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 15, bottom: 10),
              width: size.width,
              height: size.height * 0.05, // it will cover 20% of the screen

              child: Center(
                child: Text(
                  groupName,
                  style: TextStyle(
                      color: AppColors.mainBacgroundColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: AppColors.mainBacgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    )),
                
                child: ListOfTasksWidget(
                  id: groupEntity.id,
                ),
              ),
            ),
            // SizedBox(height: 10),
            // Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(36),
            //     topRight: Radius.circular(36),
            //   )),
            //   height: size.height * 0.6,
            //   child:
            // ),
          ],
        ),
        drawer: Drawer(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawerWidget(
                  username: name,
                ),
                DrawerListWidget(context, name),
              ],
            ),
          ),
        )),
        appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                onPressed: (() {
                  Scaffold.of(context).openDrawer();
                }),
                icon: Icon(
                  Icons.menu,
                  size: 25,
                  color: AppColors.mainBacgroundColor,
                ),
              );
            }),
            // title: Text(
            //   groupName,
            //   style: TextStyle(
            //       color: AppColors.mainBacgroundColor,
            //       fontSize: 22,
            //       fontWeight: FontWeight.w500,
            //       letterSpacing: 1),
            // ),
            backgroundColor: AppColors.secondMainColor,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    showAlertDialog(context, groupEntity.id, groupEntity.name);
                  },
                  icon: Icon(Icons.delete_outline,
                      color: AppColors.mainBacgroundColor)),

              // },
              // PopupMenuButton<MenuItem>(
              //     icon: Icon(Icons.delete_outline,
              //         color: AppColors.mainBacgroundColor),
              //     onSelected: (value) {
              //       if (value == MenuItem.item1) {
              //         //Clicked 'Item1'
              //       } else if (value == MenuItem.item2) {
              //         //Clicked 'Item2'

              //         BlocProvider.of<GroupListBloc>(context, listen: false)
              //             .add(DeleteGroupEvent(id: groupEntity.id));

              //         Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) => DeleteGroup(
              //               groupName: groupName,
              //               groupId: groupEntity.id,
              //             ))));
              // DeleteGroup(groupId: groupEntity.id,groupName: groupName,).build(context);
              //   }
              // },
              // itemBuilder: (context) => [
              //       PopupMenuItem(
              //         value: MenuItem.item1,
              //         child: Text('Rename group'),
              //       ),
              //       PopupMenuItem(
              //         value: MenuItem.item2,
              //         child: Text('Delete group'),
              //       ),
              //     ])
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTaskScreen(
                          id: groupEntity.id,
                        )));
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, int id, String name) {
  int count = 0;
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      BlocProvider.of<GroupListBloc>(context, listen: false)
          .add(DeleteGroupEvent(id: id));

      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
      // Navigator.popUntil(context, (route) => route.isFirst);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Are you sure you want to delete this group?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

enum MenuItem {
  item1,
  item2,
}

class DeleteGroup extends StatelessWidget {
  const DeleteGroup({
    super.key,
    required this.groupName,
    required this.groupId,
  });

  final String groupName;
  final int groupId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupState>(
      builder: ((context, state) {
        if (state is GroupLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GroupLoadedState) {
          return GroupHomeScreen(
            name: AppSettings.user!.name,
          );
          // Navigator.pop(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: ((context) => GroupHomeScreen(name: AppSettings.user!.name))));
          // Scaffold(
          //   body: Container(
          //       child: Center(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: ((context) =>
          //                     GroupHomeScreen(name: AppSettings.user!.name))));
          //       },
          //       child: Text('Press'),
          //     ),
          //   )),
          // );
        } else if (state is GroupErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                'Bad result',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
