import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task/task_bloc.dart';
import '../bloc/taskGroup/task_group_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Load task groups first
    context.read<TaskGroupBloc>().add(LoadTaskGroups());
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _initTabController(int length) {
    if (_tabController == null || _tabController!.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
      _tabController!.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          CircleAvatar(
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: BlocBuilder<TaskGroupBloc, TaskGroupState>(
            builder: (context, state) {
              if (state is TaskGroupsLoaded) {
                _initTabController(state.taskGroups.length);

                return TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.brown,
                  labelColor: Colors.brown,
                  unselectedLabelColor: Colors.white,
                  tabs: state.taskGroups
                      .map((group) => Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(group.title),
                                Container(
                                  height: 2,
                                  width: 20,
                                  color: Colors.brown,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      body: BlocBuilder<TaskGroupBloc, TaskGroupState>(
        builder: (context, groupState) {
          if (groupState is TaskGroupsLoaded) {
            _initTabController(groupState.taskGroups.length);

            return TabBarView(
              controller: _tabController,
              children: groupState.taskGroups.map((group) {
                return BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is TaskLoaded) {
                      final groupTasks = state.tasks.where((task) => group.taskIds.contains(task.id)).toList();

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: groupTasks.length,
                        itemBuilder: (context, index) {
                          final task = groupTasks[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (value) {},
                              fillColor: WidgetStateProperty.all(Colors.brown),
                            ),
                            title: Text(
                              task.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.star_border,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('No tasks found'));
                  },
                );
              }).toList(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
