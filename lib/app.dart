import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task/task_bloc.dart';
import 'bloc/taskGroup/task_group_bloc.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc()..add(LoadTasks()),
        ),
        BlocProvider(
          create: (context) => TaskGroupBloc()..add((LoadTaskGroups())),
        )
      ],
      child: MaterialApp(
        title: 'Task Management',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: Colors.brown.shade900,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
