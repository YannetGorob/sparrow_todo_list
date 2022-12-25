import 'package:flutter/material.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/form_sign_up_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
             Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.mainTextColor,
          ),
          iconSize: 30,
        ),
        // centerTitle: false,
        // title: Text(
        //   'Sign Up'.toUpperCase(),
        //   style: TextStyle(color: AppColors.mainTextColor),
        // ),
        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () {},
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 30),
        //       child: Text(
        //         'Login'.toUpperCase(),
        //         style: TextStyle(
        //             color: AppColors.mainTextColor.withOpacity(0.6),
        //             fontSize: 20,
        //             decoration: TextDecoration.underline),
        //       ),
        //     ),
        //   ),
        // ],
        backgroundColor: AppColors.mainBacgroundColor,
      ),
      body: SignUpWidget(),
    );
  }
}
