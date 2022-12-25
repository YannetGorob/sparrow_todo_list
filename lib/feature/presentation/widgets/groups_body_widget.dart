import 'package:flutter/material.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';
import 'package:sparrow_todo_list/feature/domain/entities/task_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/categories_card.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/important_tasks_widget.dart';

class GroupBodyWidget extends StatelessWidget {
  final String name;
  List<GroupEntity> group;

  GroupBodyWidget({
    super.key,
    required this.name,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    var res = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Text(
            "What's up, $name!",
            style: TextStyle(
                fontSize: 30,
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 40),
          Text(
            'Categories'.toUpperCase(),
            style: TextStyle(
                fontSize: 17,
                color: AppColors.helpTextColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          CategoriesCardWidget(
            group: group,
          ),
          SizedBox(height: 20),
          Text(
            "Important Tasks".toUpperCase(),
            style: TextStyle(
                fontSize: 17,
                color: AppColors.helpTextColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          ImportantTasksWidget(
            group: group,
          ),
        ],
      ),
    );
    return res;
  }
}
