import 'package:flutter/material.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/common/app_settings.dart';

import 'package:sparrow_todo_list/feature/domain/entities/group_entity.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/group_info_screen.dart';

class CategoriesCardWidget extends StatelessWidget {
  final List<GroupEntity> group;

  const CategoriesCardWidget({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.3,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          mainAxisExtent: 200,
        ),
        itemCount: group.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              splashColor: AppColors.mainColor.withOpacity(0.1),
              highlightColor: AppColors.helpTextColor.withOpacity(0.1),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (
                      context,
                    ) =>
                            GroupInfoScreen(
                              groupName: group[index].name,
                              name: AppSettings.user!.name,
                              groupEntity: group[index],
                            )));
              },
              child: GroupCard(
                group: group[index],
                count: group[index].tasks.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final int count;
  final GroupEntity group;
  const GroupCard({super.key, required this.group, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '$count tasks',
          style: TextStyle(color: AppColors.helpTextColor),
        ),
        SizedBox(height: 10),
        Text(
          group.name,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        Container(
          color: AppColors.secondMainColor,
          height: 5,
          width: 50,
        ),
      ]),
    );
  }
}
