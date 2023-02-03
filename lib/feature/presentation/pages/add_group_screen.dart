import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/common/app_settings.dart';
import 'package:sparrow_todo_list/feature/data/models/group/create_group_model.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_state.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/group_home_screen.dart';

class AddGroupScreen extends StatefulWidget {
  AddGroupScreen({
    super.key,
  });

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();
  final GlobalKey<FormState> groupKey = GlobalKey<FormState>();

  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: groupKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Expanded(
                      child: Align(
                    alignment: FractionalOffset.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
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
                      ),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              style: TextStyle(fontSize: 25),
                              controller: groupNameController,
                              decoration: InputDecoration(
                                  hintText: 'Enter new group name',
                                  hintStyle: TextStyle(fontSize: 25),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: groupDescriptionController,
                              style: TextStyle(fontSize: 25),
                              decoration: InputDecoration(
                                  hintText: 'Description',
                                  hintStyle: TextStyle(fontSize: 25),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: groupNameController,
                    builder: (context, value, child) {
                      return Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: value.text.isNotEmpty
                                  ? () {
                                      BlocProvider.of<GroupListBloc>(context,
                                              listen: false)
                                          .add(CreateGroupEvent(
                                        groupModel: CreateUpdateGroupModel(
                                          name: groupNameController.text,
                                          description:
                                              groupDescriptionController.text,
                                        ),
                                      ));
                                      Navigator.pop(context);
                                      // Navigator.pop(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: ((context) => SendGroup(
                                      //               groupModel:
                                      //     CreateUpdateGroupModel(
                                      //   name: groupNameController
                                      //       .text,
                                      //   description:
                                      //       groupDescriptionController
                                      //           .text,
                                      // ),
                                      //               groupName:
                                      //                   groupNameController
                                      //                       .text,
                                      //             ))));
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
                                      'New Group',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.keyboard_arrow_up)
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class SendGroup extends StatelessWidget {
//   const SendGroup({
//     super.key,
//     required this.groupModel,
//     required this.groupName,
//   });
//   final CreateUpdateGroupModel groupModel;
//   final String groupName;

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<GroupListBloc>(context, listen: false)
//         .add(CreateGroupEvent(groupModel: groupModel));
//     return BlocBuilder<GroupListBloc, GroupState>(
//       builder: ((context, state) {
//         if (state is GroupLoadingState) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is GroupLoadedState) {
//           return GroupHomeScreen(
//             name: AppSettings.user!.name,
//           );

//           // return GroupInfoScreen(
//           //   groupName: groupName,
//           //   name: AppSettings.user!.name,
//           //   groupEntity: AppSettings.group,
//           // );

//           // Scaffold(
//           //   body: Container(
//           //       child: Center(
//           //     child: ElevatedButton(
//           //       onPressed: () {
//           //         Navigator.push(
//           //             context,
//           //             MaterialPageRoute(
//           //                 builder: ((context) =>
//           //                     GroupHomeScreen(name: AppSettings.user!.name))));
//           //       },
//           //       child: Text('Press'),
//           //     ),
//           //   )),
//           // );
//         } else if (state is GroupErrorState) {
//           Scaffold(
//             body: Center(
//               child: Text(
//                 'Bad result',
//                 style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           );
//         }
//         return Container();
//       }),
//     );
//   }
// }
