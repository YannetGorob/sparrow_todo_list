import 'package:flutter/material.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';

class HeaderDrawerWidget extends StatefulWidget {
  const HeaderDrawerWidget({super.key, required this.username});
  final String username;

  @override
  State<HeaderDrawerWidget> createState() => _HeaderDrawerWidgetState();
}

class _HeaderDrawerWidgetState extends State<HeaderDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.only(top: 30),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.secondMainColor),
            ),
            Text(
              widget.username,
              style: TextStyle(
                fontSize: 23,
                color: AppColors.mainBacgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
