import 'package:get_it/get_it.dart';
import 'package:sparrow_todo_list/feature/data/datasources/account_remote_data_source.dart';
import 'package:sparrow_todo_list/feature/data/datasources/group_remote_data_source.dart';
import 'package:sparrow_todo_list/feature/data/datasources/task_remote_data_source.dart';
import 'package:sparrow_todo_list/feature/data/repositories/account_repository.dart';
import 'package:sparrow_todo_list/feature/data/repositories/group_repository.dart';
import 'package:sparrow_todo_list/feature/data/repositories/task_repository.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/account_repository.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/group_repository.dart';
import 'package:sparrow_todo_list/feature/domain/repositories/task_repository.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/group_list_bloc/group_list_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/login/login_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/sign_bloc/sign_bloc.dart';
import 'package:sparrow_todo_list/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//BloC
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignBloc(accountRepository: sl()));
  sl.registerFactory(() => GroupListBloc(groupRepository: sl()));
  sl.registerFactory(() => TaskBloc(taskRepository: sl()));

//Repository
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(accountRemoteDataSource: sl()));

  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl());

  sl.registerLazySingleton<GroupRepository>(
      () => GroupRepositoryImp(groupRemoteDataSource: sl()));

  sl.registerLazySingleton<GroupRemoteDataSource>(
      () => GroupRemoteDataSourceImpl());

  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImp(taskRemoteDataSource: sl()));

  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl());
}
