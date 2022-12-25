import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/feature/data/models/group/get_groups_model.dart';
import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_state.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/groups_body_widget.dart';

class GroupListWidget extends StatefulWidget {
  final String name;
  const GroupListWidget({super.key, required this.name});

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupListBloc>(context, listen: false).add(GetGroupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupListBloc, GroupState>(
      builder: (context, state) {
        List<GroupEntity> group = [];

        if (state is GroupLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GroupLoadedState) {
          if (state.groupModel is GroupModel) {
            group.add(state.groupModel);
          } else if (state.groupModel is List<GroupModel>) {
            group = state.groupModel;
          }

          return GroupBodyWidget(
            name: widget.name,
            group: group,
          );
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
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if ((state is GroupLoadedState) && (state.method == 'create' || state.method == 'delete')) {
          BlocProvider.of<GroupListBloc>(context, listen: false)
              .add(GetGroupEvent());
        }
      },
    );
  }
}
