import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_crud_local_storage/data/database.dart';
import 'package:flutter_task_crud_local_storage/data/datasources/local_data_source.dart';
import 'package:flutter_task_crud_local_storage/domain/repository/repository.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/bloc/task_bloc.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/screens/task_screen.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/create_task_use_case.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/delete_task_use_case.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/edit_task_use_case.dart';
import 'package:flutter_task_crud_local_storage/presentation/task/usecases/get_tasks_use_case.dart';

late AppDatabase? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await getAppDatabaseInstance();

  LocalDataSourceImpl(database: database!);

  runApp(const MyApp());
}

Future<AppDatabase> getAppDatabaseInstance() async {
  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  return database;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(
            getTasksUseCase: GetTasksUseCase(repository: RepositoryImpl(localDataSource: LocalDataSourceImpl(database: database!))),
            createTaskUseCase: CreateTaskUseCase(repository: RepositoryImpl(localDataSource: LocalDataSourceImpl(database: database!))),
            deleteTaskUseCase: DeleteTaskUseCase(repository: RepositoryImpl(localDataSource: LocalDataSourceImpl(database: database!))),
            editTaskUseCase: EditTaskUseCase(repository: RepositoryImpl(localDataSource: LocalDataSourceImpl(database: database!))),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Tasks CRUD',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TaskScreen(),
      ),
    );
  }
}
