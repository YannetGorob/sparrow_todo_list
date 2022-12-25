import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparrow_todo_list/common/app_colors.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/pages/home_screen.dart';
import 'package:sparrow_todo_list/locator_service.dart' as di;
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_bloc.dart';
import 'package:sparrow_todo_list/locator_service.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SignBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GroupListBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<TaskBloc>(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
            canvasColor: AppColors.mainBacgroundColor,
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: AppColors.mainColor,
                onPrimary: AppColors.mainBacgroundColor,
                secondary: AppColors.secondMainColor,
                onSecondary: AppColors.secondMainColor,
                error: Colors.red,
                onError: Colors.red,
                background: AppColors.mainBacgroundColor,
                onBackground: AppColors.helpTextColor,
                surface: AppColors.helpTextColor,
                onSurface: AppColors.mainTextColor),
            scaffoldBackgroundColor: AppColors.mainBacgroundColor),
        home:
            HomeScreen(), // if (token = null) => HomePage; else => SignInPage;
      ),
    );
  }
}
