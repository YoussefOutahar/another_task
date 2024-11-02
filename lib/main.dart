import 'package:another_task/bloc/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

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
