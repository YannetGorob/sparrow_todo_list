import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';

import 'package:sparrow_todo_list/feature/data/models/account/sign_in_model.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_event.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_state.dart';
import 'package:sparrow_todo_list/feature/presentation/widgets/form_sign_in_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
        backgroundColor: AppColors.mainBacgroundColor,
      ),
      body: FormWidget(),
    );
  }
}
